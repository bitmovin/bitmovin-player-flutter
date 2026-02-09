# Contributing

## Project Setup Guide
If you want to play around with the code, implement a new feature or just run the example apps, follow along with this section. If you just want to use the player in your own flutter app, you can skip this and follow the instructions in the [Getting Started Guide](README.md#getting-started-guide) section.

- [Install](https://docs.flutter.dev/get-started/install) `flutter` on your machine
- Install `Node.js` and `npm` on your machine
- Run `npm ci` in the root of the cloned repository
  - This will setup [husky](https://github.com/typicode/husky) powered pre-commit git hooks
- Run `brew bundle install` in the root of the cloned repository to install needed dependencies:
  - `ktlint` for linting Kotlin code
  - `swiftlint` for linting Swift code
- Follow instructions under [Example App](#example-app) and [Integration Tests](#integration-tests) in order to have a fully working project setup, where the linter commands from the pre-commit hook succeeds

### For iOS Development
To build the example project with your own developer account, create the config file 
`example/ios/Flutter/Developer.xcconfig`. In this file, add your development team like this:

```yml
DEVELOPMENT_TEAM = YOUR_TEAM_ID
```

## Example App
To be able to use the example app, follow these steps:
1. Create a file named `.env` in the project root
1. Put your private Bitmovin Player license key inside the newly created `.env` file as `BITMOVIN_PLAYER_LICENSE_KEY=YOUR_LICENSE_KEY`, replacing `YOUR_LICENSE_KEY` with your license key which can be obtained from [Bitmovin's Dashboard](https://bitmovin.com/dashboard)
1. If you also want to enable Bitmovin Analytics, additionally add your private Bitmovin Analytics license key to the `.env` file as 
`BITMOVIN_ANALYTICS_LICENSE_KEY=YOUR_ANALYTICS_LICENSE_KEY`, replacing `YOUR_ANALYTICS_LICENSE_KEY` with your Analytics 
license key which can be obtained from [Bitmovin's Dashboard](https://bitmovin.com/dashboard)
1. In the [Dashboard](https://bitmovin.com/dashboard), add `com.bitmovin.player.flutter.example` as an allowed package name for your Player license and optionally for your Analytics license
1. Run `flutter pub get` in the project root, if not done already
1. Run `dart run build_runner build --delete-conflicting-outputs` in the project root which should generate the missing `example/lib/env/env.g.dart` file
1. Start the example app by running the command `flutter run` inside the `example/` directory
    1. If you see an error that signing for "Runner" requires a development team, follow the instructions in the section for [getting started with iOS development](#for-ios-development)

## Pull Requests

Before creating a pull request, please

- Make sure all guidelines are followed
- Make sure your branch is free of merge conflicts

## Code Style and Linting

- Code needs to be free of linter errors. Linting is done via a pre-commit git hook for Dart, Kotlin and Swift code. Linter commands that are used by the pre-commit hook:
    - Dart: `flutter analyze`
    - Kotlin: `ktlint`
    - Swift: `./scripts/lint_swift.sh`
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
