# Contributing

## Issues

With bugs and problems, please try to describe the issue as detailed as possible to help us reproduce it.

## Pull Requests

Before creating a pull request, please

- Make sure all guidelines are followed
- Make sure your branch is free of merge conflicts

## Code Style and Linting

- Code needs to be free of linter errors. Linting is done via a pre-commit git hook for Dart, Kotlin and Swift code. Linter commands that are used by the pre-commit hook:
    - Dart: `flutter analyze`
    - Kotlin: `ktlint`
    - Swift: `mint run swiftlint`
- Public API that is exported via `lib/bitmovin_player.dart` has to be documented with a description that explains _what_ it does
- Every code block that does not obviously explain itself should be commented with an explanation of _why_ and _what_ it does

## Commit message convention

While this is not enforced, feel free to follow the [conventional commits specification](https://www.conventionalcommits.org/en) for commit messages:

- `fix`: bug fixes, e.g. fix crash due to deprecated method.
- `feat`: new features, e.g. add new method to the module.
- `refactor`: code refactor, e.g. migrate from class components to hooks.
- `docs`: changes into documentation, e.g. add usage example for the module..
- `test`: adding or updating tests, e.g. add integration tests using detox.
- `chore`: tooling changes, e.g. change CI config.

## JSON

This project uses [`json_serializable`](https://pub.dev/packages/json_serializable) to deal with JSON. After creating
a new symbol that needs JSON serialization or modifying an existing one, run the following command to generate the new or updated JSON
part files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

If generating the JSON part files fails consistently, try to clean the project beforehand:

```bash
flutter clean && flutter pub get
```

## Integration Tests

Integration tests are located under `example/integration_test/`. New integration tests should be added there for new 
features that get implemented.

The tests can be executed either through VSCode or by running `flutter test integration_test` in the `example/` 
directory.

Integration tests for the player SDK are written using a separate player testing framework which is located 
under `player_testing/`.

Before integration tests can be executed for the first time, a few set-up steps are needed:
1. Create a file named `.env` inside `player_testing`
1. Put your private Bitmovin Player license key inside the newly created `.env` file as `BITMOVIN_PLAYER_LICENSE_KEY=YOUR_LICENSE_KEY`, replacing `YOUR_LICENSE_KEY` with your license key which can be obtained from [Bitmovin's Dashboard](https://bitmovin.com/dashboard)
    1. If you already created an `.env` file in the project root, you can just copy it over to `player_testing`
1. Run `dart pub get` inside `player_testing`, if not done already
1. Run `dart run build_runner build` inside `player_testing` which should generate the missing `player_testing/lib/env/env.g.dart` file
1. Execute the integration tests by running `flutter test integration_test` in the `example/` directory
