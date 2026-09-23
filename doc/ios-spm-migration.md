# Migrating iOS applications to Swift Package Manager

This is a one-time migration from `bitmovin_player` 0.26.0 or earlier to Swift
Package Manager (SPM). Later plugin upgrades do not require repeating these steps.
The migrated plugin requires Flutter 3.44+, iOS 15+, and an Xcode version supported
by Flutter with Swift tools 5.10 or newer. New native Player releases are no longer
published to CocoaPods.

## Existing applications

1. Upgrade Flutter to 3.44 or later and update `bitmovin_player`.
2. Ensure SPM has not been disabled. Flutter 3.44 enables it by default; remove
   any `enable-swift-package-manager: false` override from your application's
   `pubspec.yaml`, or set it to `true`.
3. Set Runner's iOS deployment target to at least 15.0 in Xcode and in any
   retained Podfile.
4. Remove manually added Bitmovin Player, Player Core, and Analytics pods,
   frameworks, or packages. The plugin supplies these dependencies through SPM.
5. Run `flutter clean`, `flutter pub get`, and `flutter build ios --no-codesign`
   from your application to update the Xcode integration and remaining pods.
6. Review and commit the project, scheme, workspace `Package.resolved`, and
   `Podfile.lock` (if retained). Do not commit generated `Flutter/ephemeral` files.
7. Run the app and verify Player initialization and playback.

Flutter adds `FlutterGeneratedPluginSwiftPackage` to Runner and a
`Run Prepare Flutter Framework Script` build pre-action. For custom schemes, follow
[Flutter's migration instructions](https://docs.flutter.dev/packages-and-plugins/swift-package-manager/for-app-developers).

Do not add the native Player separately in Xcode: the plugin pins its version in
`ios/bitmovin_player/Package.swift` and supplies updates through plugin releases.

For Git/path dependencies, Flutter 3.44 requires the checkout directory to match
the Dart package name; see the [local development workaround](../CONTRIBUTING.md#for-ios-development).

## Other CocoaPods dependencies

Keep CocoaPods while your app has dependencies that need it, such as Google Cast.
After migration, `Podfile.lock` must not contain `bitmovin_player`, `BitmovinPlayer`,
`BitmovinPlayerCore`, or `BitmovinAnalyticsCollector` entries. Once all dependencies
have migrated, use Flutter's instructions above to remove CocoaPods integration.

## Legacy applications

If you cannot migrate, remain on `bitmovin_player` 0.26.0, which retains CocoaPods
and native Player 3.112.0. That version will not receive new native Player releases;
SPM and iOS 15 are required for this upgrade.
