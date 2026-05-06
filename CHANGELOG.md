# Changelog

## [Unreleased]

### Changed

- Update Bitmovin's native iOS SDK version to `3.113.0`

## [0.26.0] - 2026-05-04

### Changed

- Update Bitmovin's native Android SDK version to [`3.151.0+jason`](https://developer.bitmovin.com/playback/docs/release-notes-android#31510)
- Update Bitmovin's native iOS SDK version to [`3.112.0`](https://developer.bitmovin.com/playback/docs/release-notes-ios#31120)
- Update Kotlin version to `2.2.21`

## [0.25.0] - 2026-03-30
### Changed
- Update Bitmovin's native Android SDK version to [`3.146.0+jason`](https://developer.bitmovin.com/playback/docs/release-notes-android#31460)
- Update Bitmovin's native iOS SDK version to [`3.110.0`](https://developer.bitmovin.com/playback/docs/release-notes-ios#31100)

## [0.24.0] - 2026-02-13
### Changed
- Increased the Android `minSdkVersion` to 23
- Bitmovin Player Web UI integration migrates to v4. Checkout [what's new](https://developer.bitmovin.com/playback/docs/whats-new-in-ui-v4) for details
- Update Bitmovin's native Android Player SDK version to [`3.141.0+jason`](https://developer.bitmovin.com/playback/docs/release-notes-android#31410)
- Update Bitmovin's native iOS Player SDK version to [`3.107.0`](https://developer.bitmovin.com/playback/docs/release-notes-ios#31070)
- Use latest Google Cast iOS sender SDK (4.8.4) in example app

## [0.23.0] - 2025-12-18
### Changed
- Update Bitmovin's native Android Player SDK version to [`3.136.0`](https://developer.bitmovin.com/playback/docs/release-notes-android#31360)
- Update Bitmovin's native iOS Player SDK version to [`3.103.0`](https://developer.bitmovin.com/playback/docs/release-notes-ios#31030)

## [0.22.0] - 2025-11-28
### Changed
- Remove Beta label
- Update Bitmovin's native Android Player SDK version to [`3.133.0`](https://developer.bitmovin.com/playback/docs/release-notes-android#31330)
- Update Bitmovin's native iOS Player SDK version to [`3.100.0`](https://developer.bitmovin.com/playback/docs/release-notes-ios#31000)

## [0.21.0] - 2025-10-14
### Added
- Support for casting Widevine-protected streams from an iOS sender

### Changed
- Update Bitmovin's native Android Player SDK version to [`3.128.0`](https://developer.bitmovin.com/playback/docs/release-notes-android#31280)
- Update Bitmovin's native iOS Player SDK version to [`3.97.1`](https://developer.bitmovin.com/playback/docs/release-notes-ios#3971)

### Fixed
- Missing support for `FairplayConfig.licenseRequestHeaders` and `FairplayConfig.certificateRequestHeaders`. Those fields were not serialized to JSON and not sent through the method channel to the iOS platform side

## [0.20.0] - 2025-09-05
### Changed
- Update Bitmovin's native Android Player SDK version to [`3.125.0`](https://developer.bitmovin.com/playback/docs/release-notes-android#31250)
- Update Bitmovin's native iOS Player SDK version to [`3.94.1`](https://developer.bitmovin.com/playback/docs/release-notes-ios#3941)
- Update Kotlin version to `2.1.21`

## [0.19.0] - 2025-07-09
### Changed
- Update Bitmovin's native Android Player SDK version to [`3.117.0`](https://developer.bitmovin.com/playback/docs/release-notes-android#31170)
- Update Bitmovin's native iOS Player SDK version to [`3.92.1`](https://developer.bitmovin.com/playback/docs/release-notes-ios#3921)

## [0.18.0] - 2025-06-02
### Changed
- Update Bitmovin's native Android Player SDK version to [`3.112.0`](https://developer.bitmovin.com/playback/docs/release-notes-android#31120)
- Update Bitmovin's native iOS Player SDK version to [`3.89.0`](https://developer.bitmovin.com/playback/docs/release-notes-ios#3890)

## [0.17.0] - 2025-04-09
### Changed
- Update Bitmovin's native Android Player SDK version to [`3.106.0`](https://developer.bitmovin.com/playback/docs/release-notes-android#31060)
- Update Bitmovin's native iOS Player SDK version to [`3.86.0`](https://developer.bitmovin.com/playback/docs/release-notes-ios#3860)

## [0.16.0] - 2025-02-20
### Changed
- Replace usage of deprecated `dart:html` with new `package:web`
- Replace usage of deprecated `package:js` with new `dart:js_interop`
- Update Bitmovin's native Android Player SDK version to [`3.103.0`](https://developer.bitmovin.com/playback/docs/release-notes-android#31030)
- Update Bitmovin's native iOS Player SDK version to [`3.84.0`](https://developer.bitmovin.com/playback/docs/release-notes-ios#3840)

## [0.15.0] - 2025-01-21
### Changed
- Update Bitmovin's native Android Player SDK version to [`3.100.2`](https://developer.bitmovin.com/playback/docs/release-notes-android#31002)
- Update Bitmovin's native iOS Player SDK version to [`3.82.0`](https://developer.bitmovin.com/playback/docs/release-notes-ios#3820)

## [0.14.0] - 2024-12-13
### Added
- Google Cast support for Web platform
- Support for `Player.isPaused` and `Player.isMuted`

### Changed
- Update Bitmovin's native Android Player SDK version to [`3.99.0`](https://developer.bitmovin.com/playback/docs/release-notes-android#3990)
- Update Bitmovin's native iOS Player SDK version to [`3.80.0`](https://developer.bitmovin.com/playback/docs/release-notes-ios#3800)

## [0.13.0] - 2024-11-26
### Added
- Introduce platform support for Web
  - Supported API calls: `loadSource(source)`, `play`, `pause`, `mute`, `unmute`, `seek(time)`, `timeShift(timeShift)`, `getCurrentTime`, `getTimeShift`, `getDuration`, `getMaxTimeShift`, `isLive`, `isPlaying`, `isAirplayActive`, `isAirplayAvailable`, `castVideo`, `castStop`, `isCastAvailable`, `isCasting`, `showAirPlayTargetPicker`, `destroy`
  - Supported events: `play`,`playing`,`paused`,`timeChanged`,`seek`,`seeked`,`timeShift`,`timeShifted`,`playbackFinished`,`error`,`muted`,`unmuted`,`warning`,`ready`,`sourceLoaded`,`sourceUnloaded`

### Changed
- Update Bitmovin's native Android Player SDK version to [`3.94.0`](https://developer.bitmovin.com/playback/docs/release-notes-android#3940)
- Update Bitmovin's native iOS Player SDK version to [`3.78.0`](https://developer.bitmovin.com/playback/docs/release-notes-ios#3780)

## [0.12.0] - 2024-11-06
### Changed
- Update Bitmovin's native Android Player SDK version to [`3.91.0`](https://developer.bitmovin.com/playback/docs/release-notes-android#3910)
- Update Bitmovin's native iOS Player SDK version to [`3.77.0`](https://developer.bitmovin.com/playback/docs/release-notes-ios#3770)

### Removed
- Custom spec source `https://github.com/bitmovin/cocoapod-specs.git` from `example/ios/Podfile` as `BitmovinPlayer` is now published to the public CocoaPods registry

## [0.11.0] - 2024-09-11
### Changed
- Update Bitmovin's native Android Player SDK version to [`3.82.0`](https://developer.bitmovin.com/playback/docs/release-notes-android#3820)
- Update Bitmovin's native iOS Player SDK version to [`3.71.0`](https://developer.bitmovin.com/playback/docs/release-notes-ios#3710)

## [0.10.0] - 2024-08-07
### Changed
- Update Bitmovin's native Android Player SDK version to [`3.78.0`](https://developer.bitmovin.com/playback/docs/release-notes-android#3780)
- Update Bitmovin's native iOS Player SDK version to [`3.68.0`](https://developer.bitmovin.com/playback/docs/release-notes-ios#3680)

## [0.9.0] - 2024-07-03
### Changed
- Update example app dependency: Google Cast iOS sender SDK to `4.8.1`
- Update Bitmovin's native Android Player SDK version to [`3.75.0`](https://developer.bitmovin.com/playback/docs/release-notes-android#3750)
- Update Bitmovin's native iOS Player SDK version to [`3.66.1`](https://developer.bitmovin.com/playback/docs/release-notes-ios#3661)

## [0.8.0] - 2024-05-13
### Changed
- Update Bitmovin's native Android Player SDK version to [`3.68.0`](https://developer.bitmovin.com/playback/docs/release-notes-android#3680)
- Update Bitmovin's native iOS Player SDK version to [`3.62.0`](https://developer.bitmovin.com/playback/docs/release-notes-ios#3620)

## [0.7.0] - 2024-04-08
### Changed
- Update Bitmovin's native Android Player SDK version to [`3.65.0`](https://developer.bitmovin.com/playback/docs/release-notes-android#3650)
- Update Bitmovin's native iOS Player SDK version to [`3.59.0`](https://developer.bitmovin.com/playback/docs/release-notes-ios#3590)

## [0.6.0] - 2024-03-12
### Changed
- Update Bitmovin's native Android Player SDK version to [`3.62.0`](https://developer.bitmovin.com/playback/docs/release-notes-android#3620)
- Update Bitmovin's native iOS Player SDK version to [`3.57.0`](https://developer.bitmovin.com/playback/docs/release-notes-ios#3570)

## [0.5.0] - 2024-01-08
### Changed
- Update Bitmovin's native Android Player SDK version to [`3.55.0`](https://developer.bitmovin.com/playback/docs/release-notes-android#3550)
- Update Bitmovin's native iOS Player SDK version to [`3.52.0`](https://developer.bitmovin.com/playback/docs/release-notes-ios#3520)

### Added
- Support for Picture-in-Picture (PiP) playback on Android

### Fixed
- Android: Playback doesn't pause when app goes to background

## [0.4.0] - 2023-12-12
### Added
- Support for Picture-in-Picture (PiP) playback on iOS
  - `PictureInPictureEnter` which is emitted when the player view is about to enter Picture-in-Picture mode
  - `PictureInPictureExit` which is emitted when the player view is about to exit Picture-in-Picture mode
  - `PictureInPictureEntered` which is emitted when the player view finishes entering Picture-in-Picture mode
  - `PictureInPictureExited` which is emitted when the player view finishes exiting Picture-in-Picture mode
  - `PictureInPicture` example page to test PiP and show how it can be integrated and used
  - `PlayerViewState.pictureInPicture` namespace to access Picture-in-Picture methods
  - `PlayerViewState.pictureInPicture.isPictureInPicture` to check whether the `PlayerView` is currently in Picture-in-Picture mode
  - `PlayerViewState.pictureInPicture.isPictureInPictureAvailable` to check whether Picture-in-Picture mode is available
  - `PlayerViewState.pictureInPicture.enterPictureInPicture` to make the `PlayerView` enter Picture-In-Picture mode
  - `PlayerViewState.pictureInPicture.exitPictureInPicture` to make the `PlayerView` exit Picture-In-Picture mode
  - `PlayerViewConfig` to configure a new `PlayerView` instance. Currently its only field is `pictureInPictureConfig`
  - `PictureInPictureConfig` to configure Picture-in-Picture playback
  - `PictureInPictureConfig.isEnabled` to set whether Picture-in-Picture feature is enabled or not
  - `PictureInPictureConfig.shouldEnterOnBackground` to set whether Picture-in-Picture should start automatically when the app transitions to background

### Changed
- `PlayerView` has a new argument `playerViewConfig` with a predefined default value

## [0.3.0] - 2023-11-27
### Added
- Support for background playback on iOS
  - `PlaybackConfig.isBackgroundPlaybackEnabled` to specify whether background playback is enabled
  - `BackgroundPlayback` example to the example application
- Support for AirPlay on iOS
  - `Player.isAirPlayActive` to indicate whether media is being played externally using AirPlay
  - `Player.isAirPlayAvailable` to indicate whether AirPlay is available
  - `Player.showAirPlayTargetPicker()` to display the AirPlay playback target picker
  - `RemoteControlConfig.isAirPlayEnabled` to control whether AirPlay should be possible
  - `AirPlayAvailableEvent` which is emitted when AirPlay is available
  - `AirPlayChangedEvent` which is emitted when AirPlay playback starts or stops

### Changed
- Update Bitmovin's native Android Player SDK version to [`3.52.0`](https://developer.bitmovin.com/playback/docs/release-notes-android#3520)
- Update Bitmovin's native iOS Player SDK version to [`3.49.0`](https://developer.bitmovin.com/playback/docs/release-notes-ios#3490)

## [0.2.0] - 2023-11-06
### Added
- Google Cast Support for Android and iOS

## [0.1.0] - 2023-09-28
### Added
- Support for DASH (only Android), HLS and progressive playback
- Support for playing back live streams
- DRM support for Widevine on Android and FairPlay on iOS
- Bitmovin Web UI support, including customizable CSS and JS files
- Bitmovin Analytics support
- Subtitle & Caption handling
- Fullscreen handling
