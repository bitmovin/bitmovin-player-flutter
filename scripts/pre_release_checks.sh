#!/usr/bin/env sh
set -eu

ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
cd "$ROOT_DIR"

APPLY_UPGRADES=0
SKIP_POD_INSTALL=0
FAILURES=0

usage() {
  cat <<'EOF'
Usage: scripts/pre_release_checks.sh [options]

Runs pre-release checks for this package.

Options:
  --apply-upgrades  Runs dependency upgrades before pod install.
  --skip-pod-install Skips `pod install --repo-update` in example/ios.
  -h, --help        Show this help.
EOF
}

run_flutter() {
  if command -v fvm >/dev/null 2>&1; then
    fvm flutter "$@"
    return
  fi

  if command -v flutter >/dev/null 2>&1; then
    flutter "$@"
    return
  fi

  echo "error: neither 'fvm' nor 'flutter' is available in PATH"
  return 1
}

run_dart() {
  if command -v fvm >/dev/null 2>&1; then
    fvm dart "$@"
    return
  fi

  if command -v dart >/dev/null 2>&1; then
    dart "$@"
    return
  fi

  echo "error: neither 'fvm' nor 'dart' is available in PATH"
  return 1
}

run_step() {
  NAME="$1"
  shift

  echo
  echo "==> $NAME"
  if "$@"; then
    echo "ok: $NAME"
  else
    echo "failed: $NAME"
    FAILURES=$((FAILURES + 1))
  fi
}

print_sdk_versions() {
  ANDROID_SDK_VERSION="$(sed -n "s/.*com\\.bitmovin\\.player:player:\\([^']*\\)'.*/\\1/p" android/build.gradle | head -n 1)"
  IOS_SDK_VERSION="$(sed -n "s/.*s\\.dependency 'BitmovinPlayer', '\\([^']*\\)'.*/\\1/p" ios/bitmovin_player.podspec | head -n 1)"

  echo "Configured native Player SDK versions:"
  echo "  Android: ${ANDROID_SDK_VERSION:-not found}"
  echo "  iOS:     ${IOS_SDK_VERSION:-not found}"
  echo "  Note: if either SDK version changes, add an entry to CHANGELOG.md."
}

check_sdk_changelog_sync() {
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    if ! git diff --quiet -- ios/bitmovin_player.podspec android/build.gradle; then
      if git diff --quiet -- CHANGELOG.md; then
        echo "warning: native SDK version file changed but CHANGELOG.md is unchanged."
        return 1
      fi
    fi
  fi
}

run_outdated_checks() {
  run_step "Check outdated dependencies (all, including dev)" run_flutter pub outdated
  run_step \
    "Check pub.dev dependency constraints (no dev deps, up-to-date, no overrides)" \
    run_dart pub outdated --no-dev-dependencies --up-to-date --no-dependency-overrides
  run_step "Check outdated dependencies in player_testing" check_player_testing_outdated
}

run_publish_dry_run() {
  run_step "Check pub.dev publish dry run" run_dart pub publish --dry-run
}

run_upgrades() {
  run_step "Upgrade root dependencies (major versions allowed)" run_flutter pub upgrade --major-versions
  run_step "Upgrade example dependencies (major versions allowed)" upgrade_example_dependencies
  run_step "Upgrade player_testing dependencies (major versions allowed)" upgrade_player_testing_dependencies
}

update_pods() {
  if [ "$SKIP_POD_INSTALL" -eq 1 ]; then
    echo
    echo "==> Skipping pod install (requested)"
    return
  fi

  if ! command -v pod >/dev/null 2>&1; then
    echo
    echo "failed: pod install --repo-update (CocoaPods not found)"
    FAILURES=$((FAILURES + 1))
    return
  fi

  run_step "Install iOS pods (example/ios)" install_example_pods
}

upgrade_example_dependencies() {
  cd "$ROOT_DIR/example"
  run_flutter pub upgrade --major-versions
}

upgrade_player_testing_dependencies() {
  cd "$ROOT_DIR/player_testing"
  run_dart pub upgrade --major-versions
}

check_player_testing_outdated() {
  cd "$ROOT_DIR/player_testing"
  run_dart pub outdated
}

install_example_pods() {
  cd "$ROOT_DIR/example/ios"
  pod install --repo-update
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --apply-upgrades)
      APPLY_UPGRADES=1
      ;;
    --skip-pod-install)
      SKIP_POD_INSTALL=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "error: unknown option '$1'"
      usage
      exit 1
      ;;
  esac
  shift
done

echo "Pre-release checks for bitmovin-player-flutter"
print_sdk_versions
run_step "Link native SDK versions in CHANGELOG.md" python3 "$ROOT_DIR/scripts/link_sdk_versions.py"
run_step "Check SDK version changes include changelog updates" check_sdk_changelog_sync
run_outdated_checks
run_publish_dry_run

if [ "$APPLY_UPGRADES" -eq 1 ]; then
  run_upgrades
  update_pods
else
  echo
  echo "Skipping upgrades and pod install."
  echo "Run with '--apply-upgrades' to execute:"
  echo "  - flutter pub upgrade --major-versions (root + example)"
  echo "  - dart pub upgrade --major-versions in player_testing"
  echo "  - pod install --repo-update in example/ios"
fi

echo
if [ "$FAILURES" -eq 0 ]; then
  echo "All checks passed."
else
  echo "$FAILURES step(s) failed."
  exit 1
fi
