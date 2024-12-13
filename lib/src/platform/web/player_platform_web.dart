import 'dart:async';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/platform/cast_manager_platform_interface.dart';
import 'package:bitmovin_player/src/platform/player_platform_interface.dart';
import 'package:bitmovin_player/src/platform/web/bitmovin_player_web_api.dart';
import 'package:bitmovin_player/src/platform/web/cast_manager_platform_web.dart';
import 'package:bitmovin_player/src/platform/web/conversion.dart';
import 'package:bitmovin_player/src/platform/web/player_web_event_handler.dart';
import 'package:logger/logger.dart';
import 'package:web/web.dart' as web;

/// An implementation of [PlayerPlatformInterface] for the Web platform.
/// This is specific to a single player instance.
class PlayerPlatformWeb extends PlayerPlatformInterface {
  PlayerPlatformWeb(
    this._playerId,
    this.config,
    void Function(Event event) _onPlatformEvent,
  ) {
    _player = BitmovinPlayerJs(
      _createContainer(),
      config.toPlayerConfigJs(castManager.options),
    );

    _playerEventHandler = PlayerWebEventHandler(_player, _onPlatformEvent);
    castManager.castMessageHandler = (String message) {
      final result = _player.addMetadata('CAST', message);
      if (!result) {
        _logger.d('Failed to send CAST metadata to receiver');
      }
    };
  }

  /// Unique identifier for this player instance.
  final String _playerId;
  final Logger _logger = Logger();
  @override
  final PlayerConfig config;
  late BitmovinPlayerJs _player;
  // ignore: unused_field
  late PlayerWebEventHandler _playerEventHandler;
  CastManagerPlatformWeb get castManager =>
      CastManagerPlatformInterface.instance as CastManagerPlatformWeb;

  web.Element _createContainer() {
    final div = web.document.createElement('div') as web.HTMLDivElement
      ..id = 'player-$_playerId'
      ..style.visibility = 'hidden';

    web.document.body?.append(div);

    return div;
  }

  // TODO(mario): implement subtitle tracks API for Web
  @override
  Future<List<SubtitleTrack>> get availableSubtitles async => [];

  @override
  Future<void> castStop() async => _player.castStop();

  @override
  Future<void> castVideo() async => _player.castVideo();

  @override
  Future<double> get currentTime async => _player.getCurrentTime();

  @override
  Future<double> get duration async => _player.getDuration();

  @override
  Future<bool> get isAirPlayActive async => _player.isAirplayActive();

  @override
  Future<bool> get isAirPlayAvailable async => _player.isAirplayAvailable();

  @override
  Future<bool> get isCastAvailable async => _player.isCastAvailable();

  @override
  Future<bool> get isCasting async => _player.isCasting();

  @override
  Future<bool> get isLive async => _player.isLive();

  @override
  Future<bool> get isPlaying async => _player.isPlaying();

  @override
  Future<bool> get isPaused async => _player.isPaused();

  @override
  Future<bool> get isMuted async => _player.isMuted();

  @override
  Future<void> loadSource(Source source) async {
    await super.loadSource(source);
    _player.load(source.toSourceJs());
  }

  @override
  Future<double> get maxTimeShift async => _player.getMaxTimeShift();

  @override
  Future<void> mute() async => _player.mute();

  @override
  Future<void> pause() async => _player.pause();

  @override
  Future<void> play() async => _player.play();

  @override
  Future<void> removeSubtitle(String id) async => throw UnimplementedError();

  @override
  Future<void> seek(double time) async => _player.seek(time);

  @override
  Future<void> setSubtitle(String? id) async => throw UnimplementedError();

  @override
  Future<void> setTimeShift(double timeShift) async =>
      _player.timeShift(timeShift);

  @override
  Future<void> showAirPlayTargetPicker() async =>
      _player.showAirplayTargetPicker();

  @override
  Future<SubtitleTrack> get subtitle async => throw UnimplementedError();

  @override
  Future<double> get timeShift async => _player.getTimeShift();

  @override
  Future<void> unmute() async => _player.unmute();

  @override
  Future<void> dispose() async => _player.destroy();

  @override
  Future<void> sendCustomDataEvent(CustomData customData) async =>
      throw UnimplementedError();
}
