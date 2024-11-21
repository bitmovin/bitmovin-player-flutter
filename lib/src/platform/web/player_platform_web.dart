import 'dart:async';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/platform/player_platform_interface.dart';

/// An implementation of [PlayerPlatformInterface] that uses method channels.
/// Is specific to a single player instance.
class PlayerPlatformWeb extends PlayerPlatformInterface {
  PlayerPlatformWeb(
    this._playerId,
    this.config,
    this._onPlatformEvent,
  );

  /// Unique identifier for this player instance.
  // ignore: unused_field
  final String _playerId;

  @override
  final PlayerConfig config;

  // ignore: unused_field
  final void Function(dynamic event) _onPlatformEvent;

  @override
  Future<List<SubtitleTrack>> get availableSubtitles async =>
      throw UnimplementedError();

  @override
  Future<void> castStop() async => throw UnimplementedError();

  @override
  Future<void> castVideo() async => throw UnimplementedError();

  @override
  Future<double> get currentTime async => throw UnimplementedError();

  @override
  Future<double> get duration async => throw UnimplementedError();

  @override
  Future<bool> get isAirPlayActive async => throw UnimplementedError();

  @override
  Future<bool> get isAirPlayAvailable async => throw UnimplementedError();

  @override
  Future<bool> get isCastAvailable async => throw UnimplementedError();

  @override
  Future<bool> get isCasting async => throw UnimplementedError();

  @override
  Future<bool> get isLive async => throw UnimplementedError();

  @override
  Future<bool> get isPlaying async => throw UnimplementedError();

  @override
  Future<void> loadSource(Source source) => throw UnimplementedError();

  @override
  Future<double> get maxTimeShift async => throw UnimplementedError();

  @override
  Future<void> mute() async => throw UnimplementedError();

  @override
  Future<void> pause() async => throw UnimplementedError();

  @override
  Future<void> play() => throw UnimplementedError();

  @override
  Future<void> removeSubtitle(String id) async => throw UnimplementedError();

  @override
  Future<void> seek(double time) async => throw UnimplementedError();

  @override
  Future<void> setSubtitle(String? id) async => throw UnimplementedError();

  @override
  Future<void> setTimeShift(double timeShift) async =>
      throw UnimplementedError();

  @override
  Future<void> showAirPlayTargetPicker() async => throw UnimplementedError();

  @override
  Future<SubtitleTrack> get subtitle async => throw UnimplementedError();

  @override
  Future<double> get timeShift async => throw UnimplementedError();

  @override
  Future<void> unmute() async => throw UnimplementedError();

  @override
  Future<void> dispose() async => throw UnimplementedError();

  @override
  Future<void> sendCustomDataEvent(CustomData customData) async =>
      throw UnimplementedError();
}
