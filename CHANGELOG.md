# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]
### Changed
- APIs that returned placeholder values on invalid state now return null:
  - `player.availableSubtitles` now returns `null` when there is no active source
  - `player.subtitle` now returns `null` when there is no active subtitle track

## [0.1.0] - 2023-09-28
### Added
- Support for DASH (only Android), HLS and progressive playback
- Support for playing back live streams 
- DRM support for Widevine on Android and FairPlay on iOS
- Bitmovin Web UI support, including customizable CSS and JS files
- Bitmovin Analytics support
- Subtitle & Caption handling
- Fullscreen handling
