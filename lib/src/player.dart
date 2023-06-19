import 'package:bitmovin_sdk/src/api/player/player_config.dart';
import 'package:bitmovin_sdk/src/api/source/source.dart';
import 'package:bitmovin_sdk/src/api/source_config.dart';
import 'package:bitmovin_sdk/src/channel_manager.dart';
import 'package:bitmovin_sdk/src/channels.dart';
import 'package:bitmovin_sdk/src/drm/fairplay_handler.dart';
import 'package:bitmovin_sdk/src/interfaces/player_event_interface.dart';
import 'package:bitmovin_sdk/src/methods.dart';
import 'package:bitmovin_sdk/src/player_event_listener.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class Player with PlayerEventListener implements PlayerInterface {
  Player([
    this.playerConfig = const PlayerConfig(),
  ]) {
    _uuid = hashCode.toString();

    final mainChannel = ChannelManager.registerMethodChannel(
      name: Channels.main,
    );

    mainChannel
        .invokeMethod<bool>(
      Methods.createPlayer,
      Map<String, dynamic>.from(
        {
          'id': _uuid,
          'playerConfig': playerConfig?.toJson(),
        },
      ),
    )
        .then((value) {
      if (value != null && value == true) {
        _methodChannel = ChannelManager.registerMethodChannel(
          name: '${Channels.player}-$_uuid',
          handler: _playerMethodCallHandler,
        );

        _eventChannel = ChannelManager.registerEventChannel(
          name: '${Channels.playerEvent}-$_uuid',
        );
        _eventChannel.receiveBroadcastStream().listen(onEvent);
      }
    });
  }

  final PlayerConfig? playerConfig;
  final Logger logger = Logger(printer: PrettyPrinter());
  late String _uuid;
  // Private method channel for this player instance
  late MethodChannel _methodChannel;
  // Private method channel for this player instance to receive events
  late EventChannel _eventChannel;
  String get id => _uuid;
  FairplayHandler? fairplayHandler;

  Future<dynamic> _playerMethodCallHandler(MethodCall methodCall) {
    dynamic result;

    switch (methodCall.method) {
      case Methods.fairplayPrepareMessage:
        result = fairplayHandler?.handleMethodCall(methodCall);
        break;
    }

    if (result == null) {
      return Future.error('playerMethodCallHandler was unsuccessful');
    }

    return Future.value(result);
  }

  Map<String, dynamic> _buildPayload([dynamic data]) {
    return Map<String, dynamic>.from({
      'id': id,
      'data': data,
    });
  }

  Future<T?> _invokeMethod<T>(
    String methodName, [
    dynamic data,
  ]) =>
      _methodChannel.invokeMethod<T>(methodName, _buildPayload(data));

  /// Starts a new playback session consisting of a [Source] based
  /// on the provided [SourceConfig].
  // TODO(mario): Rename as the "with" naming seems to be uncommon in dart
  @override
  Future<void> loadWithSourceConfig(
    SourceConfig sourceConfig,
  ) async {
    return loadWithSource(Source(sourceConfig: sourceConfig));
  }

  /// Starts a new playback session consisting of the [Source].
  // TODO(mario): Rename as the "with" naming seems to be uncommon in dart
  @override
  Future<void> loadWithSource(Source source) async {
    final fairplayConfig = source.sourceConfig.drmConfig?.fairplay;
    if (fairplayConfig != null) {
      fairplayHandler = FairplayHandler(fairplayConfig);
    }

    return _invokeMethod<void>(Methods.loadWithSource, source.toJson());
  }

  /// Starts or resumes playback.
  @override
  Future<void> play() async => _invokeMethod<void>(Methods.play);

  /// Mutes the player.
  @override
  Future<void> mute() async => _invokeMethod<void>(Methods.mute);

  /// Unmutes the player.
  @override
  Future<void> unmute() async => _invokeMethod<void>(Methods.unmute);

  /// Pauses playback.
  @override
  Future<void> pause() async => _invokeMethod<void>(Methods.pause);

  /// Seeks to the given playback time in seconds.
  /// Must not be greater than the duration of the active [Source].
  @override
  Future<void> seek(double time) async =>
      _invokeMethod<void>(Methods.seek, time);

  /// The current playback time of the active [Source] or ad in seconds.
  @override
  Future<double> currentTime() async {
    return await _invokeMethod<double>(Methods.currentTime) ?? 0.0;
  }

  /// The duration of the active [Source] in seconds.
  ///
  /// If it's a VoD or Double.POSITIVE_INFINITY if it's a live stream.
  ///
  /// If isAd is true the duration of the current ad is returned.
  @override
  Future<double> duration() async {
    return await _invokeMethod<double>(Methods.duration) ?? 0.0;
  }

  Future<void> dispose() async => _invokeMethod(Methods.destroy);
}
