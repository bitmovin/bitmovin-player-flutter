import 'dart:async';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/platform/player_platform_interface.dart';
import 'package:bitmovin_player/src/platform/web/bitmovin_player_web_api.dart';
import 'package:web/web.dart';

/// An implementation of [PlayerPlatformInterface] that uses method channels.
/// Is specific to a single player instance.
class PlayerPlatformWeb extends PlayerPlatformInterface {
  PlayerPlatformWeb(
    this._playerId,
    this.config,
    this._onPlatformEvent,
  ) {
    _player = BitmovinPlayerJs(
      _createContainer(),
      PlayerConfigJs(
        key: config.key ?? '',
      ),
    );
  }

  /// Unique identifier for this player instance.
  // ignore: unused_field
  final String _playerId;

  @override
  final PlayerConfig config;

  // ignore: unused_field
  final void Function(dynamic event) _onPlatformEvent;

  // ignore: unused_field
  late BitmovinPlayerJs _player;

  Element _createContainer() {
    final div = document.createElement('div') as HTMLDivElement
      ..id = 'player-$_playerId'
      ..style.visibility = 'hidden';

    document.body?.append(div);

    return div;
  }

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
  Future<void> loadSource(Source source) async {
    await super.loadSource(source);

    String? dash;
    if (source.sourceConfig.type == SourceType.dash) {
      dash = source.sourceConfig.url;
    }

    String? hls;
    if (source.sourceConfig.type == SourceType.hls) {
      hls = source.sourceConfig.url;
    }

    _player.load(
      SourceJs(
        title: source.sourceConfig.title,
        description: source.sourceConfig.description,
        dash: dash,
        hls: hls,
        poster: source.sourceConfig.posterSource,
      ),
    );
  }

  @override
  Future<double> get maxTimeShift async => throw UnimplementedError();

  @override
  Future<void> mute() async => _player.mute();

  @override
  Future<void> pause() async => _player.pause();

  @override
  Future<void> play() async => _player.play();

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
  Future<void> unmute() async => _player.unmute();

  @override
  Future<void> dispose() async => throw UnimplementedError();

  @override
  Future<void> sendCustomDataEvent(CustomData customData) async =>
      throw UnimplementedError();
}
