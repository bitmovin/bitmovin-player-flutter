# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]
### Added
- Support for automated released (TODO: remove again)

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
- Update Bitmovin's native Android Player SDK version to `3.52.0`
- Update Bitmovin's native iOS Player SDK version to `3.49.0`

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
