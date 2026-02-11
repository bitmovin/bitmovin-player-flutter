#!/usr/bin/env sh
set -eu

if [ -n "${CI:-}" ] && [ "${SKIP_SWIFTLINT_IN_CI:-}" = "1" ]; then
  echo "Skipping SwiftLint in CI (handled by workflow)"
  exit 0
fi

if ! command -v swiftlint >/dev/null 2>&1; then
  echo "warning: SwiftLint not installed, run \`brew bundle install\` in project root to install"
  exit 0
fi

swiftlint lint --strict ios/Classes
