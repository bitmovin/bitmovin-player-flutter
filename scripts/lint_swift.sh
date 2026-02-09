#!/usr/bin/env sh
set -eu

if ! command -v swiftlint >/dev/null 2>&1; then
  echo "warning: SwiftLint not installed, run \`brew bundle install\` in project root to install"
  exit 0
fi

swiftlint --strict --path ios/Classes
