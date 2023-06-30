import 'dart:async';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/channel_manager.dart';
import 'package:bitmovin_player/src/channels.dart';
import 'package:bitmovin_player/src/drm/fairplay_handler.dart';
import 'package:bitmovin_player/src/drm/widevine_handler.dart';
import 'package:bitmovin_player/src/methods.dart';
import 'package:bitmovin_player/src/player_event_listener.dart';
import 'package:flutter/services.dart';

/// Loads, controls and renders audio and video content represented through
/// [Source]s.
///
/// The player emits events during its lifecycle. See [PlayerEventListener] on
/// how to subscribe to events. Events are divided into player events and
/// source events, depending on if they are specific to the player or a source.
///
/// By default, a player instance does not provide any UI components. To use the
/// default Bitmovin Player Web UI, a player instance can be attached to a
/// [PlayerView].
class Player with PlayerEventListener implements PlayerInterface {
  Player({
    this.config = const PlayerConfig(),
  }) {
    _initializationResult = _completer.future;
    _uuid = hashCode.toString();

    final mainChannel = ChannelManager.registerMethodChannel(
      name: Channels.main,
    );

    mainChannel
        .invokeMethod<bool>(
      Methods.createPlayer,
      Map<String, dynamic>.from(
        {
          'id': id,
          'playerConfig': config.toJson(),
        },
      ),
    )
        .then((value) {
      if (value == null || value == false) {
        _completer.complete(false);
        return;
      }

      _methodChannel = ChannelManager.registerMethodChannel(
        name: '${Channels.player}-$id',
        handler: _playerMethodCallHandler,
      );

      _eventChannel = ChannelManager.registerEventChannel(
        name: '${Channels.playerEvent}-$id',
      );
      _eventChannel.receiveBroadcastStream().listen(onEvent);

      _completer.complete(true);
    });
  }

  /// The player config.
  final PlayerConfig config;

  /// Unique identifier for this player instance.
  String get id => _uuid;
  late String _uuid;

  /// Whether the player has been created successfully on the native platform
  /// side. If `true`, the player is ready to be used. If `false`, there was an
  /// error during player creation on the native platform side.
  late Future<bool> _initializationResult;

  /// Used to generate the [_initializationResult] future.
  final _completer = Completer<bool>();

  /// Private method channel for this player instance
  late MethodChannel _methodChannel;

  /// Private method channel for this player instance to receive events
  late EventChannel _eventChannel;

  /// Handles Fairplay DRM related method calls.
  FairplayHandler? _fairplayHandler;

  /// Handles Widevine DRM related method calls.
  WidevineHandler? _widevineHandler;

  Future<dynamic> _playerMethodCallHandler(MethodCall methodCall) {
    dynamic result;

    switch (methodCall.method) {
      case Methods.fairplayPrepareMessage:
      case Methods.fairplayPrepareContentId:
      case Methods.fairplayPrepareCertificate:
      case Methods.fairplayPrepareLicense:
      case Methods.fairplayPrepareLicenseServerUrl:
      case Methods.fairplayPrepareSyncMessage:
        result = _fairplayHandler?.handleMethodCall(methodCall);
        break;
      case Methods.widevinePrepareMessage:
      case Methods.widevinePrepareLicense:
        result = _widevineHandler?.handleMethodCall(methodCall);
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
  ]) async {
    final result = await _initializationResult;
    if (!result) {
      return Future.error('Error initializing player on native platform side.');
    }
    return _methodChannel.invokeMethod<T>(methodName, _buildPayload(data));
  }

  /// Starts a new playback session with a [Source] that is created based on
  /// the provided [SourceConfig].
  @override
  Future<void> loadSourceConfig(
    SourceConfig sourceConfig,
  ) async {
    return loadSource(Source(sourceConfig: sourceConfig));
  }

  /// Starts a new playback session with the provided [Source].
  @override
  Future<void> loadSource(Source source) async {
    final fairplayConfig = source.sourceConfig.drmConfig?.fairplay;
    if (fairplayConfig != null) {
      _fairplayHandler = FairplayHandler(fairplayConfig);
    }

    final widevineConfig = source.sourceConfig.drmConfig?.widevine;
    if (widevineConfig != null) {
      _widevineHandler = WidevineHandler(widevineConfig);
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

  /// The current playback time of the active [Source] in seconds.
  @override
  Future<double> currentTime() async {
    return await _invokeMethod<double>(Methods.currentTime) ?? 0.0;
  }

  /// The duration of the active [Source] in seconds.
  @override
  Future<double> duration() async {
    return await _invokeMethod<double>(Methods.duration) ?? 0.0;
  }

  /// Disposes the player instance.
  Future<void> dispose() async => _invokeMethod(Methods.destroy);
}
