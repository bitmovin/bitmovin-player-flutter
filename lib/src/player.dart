import 'dart:async';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/api/player/player_api.dart';
import 'package:bitmovin_player/src/platform/bitmovin_player_platform_interface.dart';
import 'package:bitmovin_player/src/platform/player_platform_interface.dart';
import 'package:bitmovin_player/src/player_event_handler.dart';

/// Loads, controls and renders audio and video content represented through
/// [Source]s.
///
/// The player emits events during its lifecycle. See [PlayerEventHandler] on
/// how to subscribe to events. Events are divided into player events and
/// source events, depending on if they are specific to the player or a source.
///
/// By default, a player instance does not provide any UI components. To use the
/// default Bitmovin Player Web UI, a player instance can be attached to a
/// [PlayerView].
class Player with PlayerEventHandler implements PlayerApi {
  Player({
    PlayerConfig config = const PlayerConfig(),
  }) {
    _uuid = hashCode.toString();
    _playerPlatformInterface = BitmovinPlayerPlatformInterface.instance
        .createPlayer(id, config, onPlatformEvent);
  }

  /// Interface to the platform-specific player implementation.
  late final PlayerPlatformInterface _playerPlatformInterface;

  /// Unique identifier for this player instance.
  String get id => _uuid;
  late String _uuid;

  @override
  PlayerConfig get config => _playerPlatformInterface.config;

  @override
  Future<void> loadSourceConfig(SourceConfig sourceConfig) async =>
      _playerPlatformInterface.loadSourceConfig(sourceConfig);

  @override
  Future<void> loadSource(Source source) async =>
      _playerPlatformInterface.loadSource(source);

  @override
  Future<void> play() async => _playerPlatformInterface.play();

  @override
  Future<void> mute() async => _playerPlatformInterface.mute();

  @override
  Future<void> unmute() async => _playerPlatformInterface.unmute();

  @override
  Future<void> pause() async => _playerPlatformInterface.pause();

  @override
  Future<void> seek(double time) async => _playerPlatformInterface.seek(time);

  @override
  Future<double> get currentTime async => _playerPlatformInterface.currentTime;

  @override
  Future<double> get duration async => _playerPlatformInterface.duration;

  @override
  Future<double> get timeShift async => _playerPlatformInterface.timeShift;

  @override
  Future<void> setTimeShift(double timeShift) async =>
      _playerPlatformInterface.setTimeShift(timeShift);

  @override
  Future<double> get maxTimeShift async =>
      _playerPlatformInterface.maxTimeShift;

  @override
  Future<bool> get isLive async => _playerPlatformInterface.isLive;

  @override
  Future<bool> get isPlaying async => _playerPlatformInterface.isPlaying;

  @override
  Future<List<SubtitleTrack>> get availableSubtitles async =>
      _playerPlatformInterface.availableSubtitles;

  @override
  Future<void> removeSubtitle(String id) async =>
      _playerPlatformInterface.removeSubtitle(id);

  @override
  Future<void> setSubtitle(String? id) async =>
      _playerPlatformInterface.setSubtitle(id);

  @override
  Future<SubtitleTrack> get subtitle async => _playerPlatformInterface.subtitle;

  @override
  Future<void> dispose() async => _playerPlatformInterface.dispose();

  @override
  AnalyticsApi get analytics => _playerPlatformInterface.analytics;

  @override
  Future<bool> get isCastAvailable async =>
      _playerPlatformInterface.isCastAvailable;

  @override
  Future<bool> get isCasting async => _playerPlatformInterface.isCasting;

  @override
  Future<void> castVideo() async => _playerPlatformInterface.castVideo();

  @override
  Future<void> castStop() async => _playerPlatformInterface.castStop;

  @override
  Future<bool> get isAirPlayActive async =>
      _playerPlatformInterface.isAirPlayActive;

  @override
  Future<bool> get isAirPlayAvailable async =>
      _playerPlatformInterface.isAirPlayAvailable;

  @override
  Future<void> showAirPlayTargetPicker() async =>
      _playerPlatformInterface.showAirPlayTargetPicker();
}
