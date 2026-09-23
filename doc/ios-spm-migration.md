# Migrating iOS applications to Swift Package Manager

The Flutter plugin now uses Swift Package Manager (SPM) to install the native
Bitmovin Player and its Analytics dependencies. New native Player releases are
no longer published to CocoaPods. This release requires Flutter 3.44 or later
and iOS 15 or later. Use an Xcode version supported by your Flutter SDK; the
native Player package requires Swift tools 5.10 or newer.

## Existing applications

1. Upgrade Flutter to 3.44 or later and update the `bitmovin_player` dependency.
2. Enable SPM in your application's `pubspec.yaml`:

   ```yaml
   flutter:
     config:
       enable-swift-package-manager: true
   ```

3. Set the Runner target's iOS deployment target to at least 15.0 in Xcode.
   If you retain a Podfile for other dependencies, update its platform to match.
4. Remove any manually added Bitmovin Player, Player Core, or Analytics pods
   and any manually added copies of their frameworks/packages. The Flutter
   plugin supplies these dependencies through its package manifest.
5. Run `flutter clean`, `flutter pub get`, and `flutter build ios --no-codesign`
   from your application. Flutter adds SPM integration to the Xcode project and
   scheme and updates any remaining CocoaPods dependencies.
6. Review and commit the application project, scheme, `Podfile.lock` (if retained),
   and Xcode workspace `Package.resolved` changes. Do not commit generated
   `Flutter/ephemeral` files.
7. Run your application and verify Player initialization and playback.

Flutter should add `FlutterGeneratedPluginSwiftPackage` to Runner and a
`Run Prepare Flutter Framework Script` build pre-action. If your project uses
custom schemes, check each one using [Flutter's migration instructions](https://docs.flutter.dev/packages-and-plugins/swift-package-manager/for-app-developers).

Do not add the native Player separately in Xcode. The plugin pins the tested
native version in `ios/bitmovin_player/Package.swift`; updating the Flutter
plugin is how applications receive new native Player versions.

## Local and Git dependencies

Flutter 3.44 has a [known package identity issue](https://github.com/flutter/flutter/issues/186881)
when a local checkout directory differs from the Dart package name. For local
development, clone this repository into `bitmovin_player` and use a path dependency.
Use the published pub.dev package for applications; direct Git dependencies with
the repository name `bitmovin-player-flutter` are not supported with Flutter 3.44.
The upstream fix must reach a supported stable Flutter version before lifting
this restriction.

## Other CocoaPods dependencies

SPM and CocoaPods can coexist for different dependencies. The example retains
`google-cast-sdk` in its Podfile. Keep CocoaPods if your app needs Cast or another
dependency that still uses it. After migration, the Podfile.lock must not contain
`bitmovin_player`, `BitmovinPlayer`, `BitmovinPlayerCore`, or
`BitmovinAnalyticsCollector` entries.

Only remove CocoaPods entirely after all remaining dependencies have migrated.
See Flutter's instructions above for removing the CocoaPods integration.

### Expected non-standard Podfile warning

When building the example, Flutter may print:

> All plugins found for ios are Swift Packages, but your project still has CocoaPods integration. Your project uses a non-standard Podfile and will need to be migrated to Swift Package Manager manually.

This warning is expected and does not indicate a build failure. The Flutter
plugins use SPM, while the example's Podfile installs Google Cast directly and
adjusts deployment targets. Flutter cannot automatically remove that custom setup.

Keep the Podfile and the CocoaPods includes in `Debug.xcconfig` and
`Release.xcconfig`. Do not run `pod deintegrate` for this example while Google
Cast still uses CocoaPods; doing so removes its Cast integration. The warning
can be ignored for this setup. Removing it requires migrating the remaining
CocoaPods dependencies first.

## Legacy applications

Applications that cannot migrate must remain on a previously published Flutter
plugin version that includes a podspec, such as 0.26.0 (native Player 3.112.0).
Those applications can use the already published native CocoaPods versions but
will not receive new native Player releases. Disabling SPM is not supported by
this release. Moving to native Player 3.124.0 also ends iOS 14 support.
