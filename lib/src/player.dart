import 'dart:async';
import 'dart:convert';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/api/player/player_api.dart';
import 'package:bitmovin_player/src/channel_manager.dart';
import 'package:bitmovin_player/src/channels.dart';
import 'package:bitmovin_player/src/drm/fairplay_handler.dart';
import 'package:bitmovin_player/src/drm/widevine_handler.dart';
import 'package:bitmovin_player/src/methods.dart';
import 'package:bitmovin_player/src/player_event_handler.dart';
import 'package:flutter/services.dart';

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
      _eventChannel.receiveBroadcastStream().listen(onPlatformEvent);

      _completer.complete(true);
    });
  }

  @override
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

  // Can be used to call methods on the platform side that return a single
  // primitive value that is natively supported by the method channel.
  Future<T?> _invokeMethodNullable<T>(
    String methodName, [
    dynamic data,
  ]) async {
    final result = await _initializationResult;
    if (!result) {
      throw Exception('Error initializing player on native platform side.');
    }
    return _methodChannel.invokeMethod<T>(methodName, _buildPayload(data));
  }

  Future<T> _invokeMethod<T>(
    String methodName, [
    dynamic data,
  ]) async {
    final result = await _invokeMethodNullable<T>(methodName, data);
    if (result == null) {
      throw Exception('Invalid type returned from the native platform side.');
    }
    return result;
  }

  // Can be used to call methods on the platform side that return a complex
  // object that is not natively supported by the method channel.
  Future<T?> _invokeObjectMethod<T>(
    String methodName,
    T Function(Map<String, dynamic>) fromJson, [
    dynamic data,
  ]) async {
    final result = await _initializationResult;
    if (!result) {
      throw Exception('Error initializing player on native platform side.');
    }

    final jsonString = await _methodChannel.invokeMethod<String>(
      methodName,
      _buildPayload(data),
    );

    if (jsonString == null) {
      return null;
    }

    return fromJson(
      jsonDecode(jsonString) as Map<String, dynamic>,
    );
  }

  // Can be used to call methods on the platform side that return a list of
  // complex objects that are not natively supported by the method channel.
  Future<List<T>> _invokeListObjectsMethod<T>(
    String methodName,
    T Function(Map<String, dynamic>) fromJson, [
    dynamic data,
  ]) async {
    final result = await _initializationResult;
    if (!result) {
      return Future.error('Error initializing player on native platform side.');
    }

    final jsonStringList = await _methodChannel.invokeListMethod<String>(
      methodName,
      _buildPayload(data),
    );

    if (jsonStringList == null) {
      return [];
    }

    return jsonStringList.map((String jsonString) {
      return fromJson(
        jsonDecode(jsonString) as Map<String, dynamic>,
      );
    }).toList();
  }

  @override
  Future<void> loadSourceConfig(
    SourceConfig sourceConfig,
  ) async {
    return loadSource(Source(sourceConfig: sourceConfig));
  }

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

  @override
  Future<void> play() async => _invokeMethod<void>(Methods.play);

  @override
  Future<void> mute() async => _invokeMethod<void>(Methods.mute);

  @override
  Future<void> unmute() async => _invokeMethod<void>(Methods.unmute);

  @override
  Future<void> pause() async => _invokeMethod<void>(Methods.pause);

  @override
  Future<void> seek(double time) async =>
      _invokeMethod<void>(Methods.seek, time);

  @override
  Future<double> get currentTime async =>
      _invokeMethod<double>(Methods.currentTime);

  @override
  Future<double> get duration async => _invokeMethod<double>(Methods.duration);

  @override
  Future<double> get timeShift async =>
      _invokeMethod<double>(Methods.getTimeShift);

  @override
  Future<void> setTimeShift(double timeShift) async =>
      _invokeMethod<void>(Methods.setTimeShift, timeShift);

  @override
  Future<double> get maxTimeShift async =>
      _invokeMethod<double>(Methods.maxTimeShift);

  @override
  Future<bool> get isLive async => _invokeMethod<bool>(Methods.isLive);

  @override
  Future<bool> get isPlaying async => _invokeMethod<bool>(Methods.isPlaying);

  @override
  Future<List<SubtitleTrack>> get availableSubtitles async =>
      _invokeListObjectsMethod<SubtitleTrack>(
        Methods.availableSubtitles,
        SubtitleTrack.fromJson,
      );

  @override
  Future<void> removeSubtitle(String id) async =>
      _invokeMethod<void>(Methods.removeSubtitle, id);

  @override
  Future<void> setSubtitle(String? id) async =>
      _invokeMethod<void>(Methods.setSubtitle, id);

  @override
  Future<SubtitleTrack> get subtitle async =>
      await _invokeObjectMethod<SubtitleTrack>(
        Methods.getSubtitle,
        SubtitleTrack.fromJson,
      ) ??
      SubtitleTrack.off();

  /// Disposes the player instance.
  Future<void> dispose() async => _invokeMethod<void>(Methods.destroy);

  @override
  AnalyticsApi get analytics => _AnalyticsApi(this);
}

class _AnalyticsApi implements AnalyticsApi {
  _AnalyticsApi(this._player);

  final Player _player;

  @override
  Future<void> sendCustomDataEvent(CustomData customData) async => _player
      ._invokeMethod<void>(Methods.sendCustomDataEvent, customData.toJson());
}
