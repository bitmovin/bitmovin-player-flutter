# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

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
