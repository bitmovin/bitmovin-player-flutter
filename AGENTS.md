# Repository guidance

This is the public Flutter wrapper for the native Bitmovin iOS and Android players.

- Read [CONTRIBUTING.md](CONTRIBUTING.md) for setup, the pinned Flutter SDK, code generation, and testing. Use the current [build workflow](.github/workflows/build-workspace.yml) for CI checks.
- Public Dart exports live in `lib/bitmovin_player.dart`; native bridges are in `ios/` and `android/`. Add behavioral coverage in `example/integration_test/`, using `player_testing/` where needed.
- Before drafting a PR, read the current template and [PR writing guide](doc/pull-request-writing.md). Explain why, keep only meaningful highlights, describe coverage changes, and delete inapplicable checks. Retained reviewer manual-testing checks require runnable smoke instructions and expected results.
- Keep internal tickets, private URLs, customer details, credentials, and local investigation notes out of public changes.
