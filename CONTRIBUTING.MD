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
