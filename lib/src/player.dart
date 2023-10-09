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
    _uuid = hashCode.toString();
    _nativePlayerHandle = _createNativePlayer();
  }

  Future<_NativePlayerHandle> _createNativePlayer() async {
    final mainChannel = ChannelManager.registerMethodChannel(
      name: Channels.main,
    );

    final success = await mainChannel.invokeMethod<bool>(
        Methods.createPlayer,
        Map<String, dynamic>.from(
          {
            'id': id,
            'playerConfig': config.toJson(),
          },
        ),
      );
      if (success == null || success == false) {
        throw Exception('Error initializing player on native platform side.');
      }
      final methodChannel = ChannelManager.registerMethodChannel(
        name: '${Channels.player}-$id',
        handler: _playerMethodCallHandler,
      );
      final eventChannel = ChannelManager.registerEventChannel(
        name: '${Channels.playerEvent}-$id',
        onEvent: onPlatformEvent,
      );

      return _NativePlayerHandle(methodChannel, eventChannel);
  }

  @override
  final PlayerConfig config;

  /// Unique identifier for this player instance.
  String get id => _uuid;
  late String _uuid;

  /// Player native communication channels.
  /// Available once the native player is created.
  late Future<_NativePlayerHandle> _nativePlayerHandle;

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
  Future<T> _invokeMethod<T>(
    String methodName, [
    dynamic data,
  ]) async {
    final methodChannel = (await _nativePlayerHandle).methodChannel;
    final payload = _buildPayload(data);
    final result = await methodChannel.invokeMethod<T>(methodName, payload);
    if (result is! T) {
      // result is T?, if it `is` not T => T is not nullable and result is null.
      throw Exception('Native $methodName returned null.');
    }
    return result;
  }

  // Can be used to call methods on the platform side that return a complex
  // object that is not natively supported by the method channel.
  Future<T> _invokeObjectMethod<T>(
    String methodName,
    T Function(Map<String, dynamic>) fromJson, [
    dynamic data,
  ]) async {
    final String jsonString;
    const T? tNull = null;
    if (tNull is T) { // T is nullable
      final jsonStringOrNull = await _invokeMethod<String?>(methodName, data);
      if (jsonStringOrNull == null) return tNull;
      jsonString = jsonStringOrNull;
    } else {
      jsonString = await _invokeMethod<String>(methodName, data);
    }
    return fromJson(jsonDecode(jsonString) as Map<String, dynamic>);
  }

  // Can be used to call methods on the platform side that return a list of
  // complex objects that are not natively supported by the method channel.
  Future<List<T>?> _invokeListObjectsMethod<T>(
    String methodName,
    T Function(Map<String, dynamic>) fromJson, [
    dynamic data,
  ]) async {
    final methodChannel = (await _nativePlayerHandle).methodChannel;

    final jsonStringList = await methodChannel.invokeListMethod<String>(
      methodName,
      _buildPayload(data),
    );

    if (jsonStringList == null) {
      return null;
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
  Future<List<SubtitleTrack>?> get availableSubtitles async =>
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
  Future<SubtitleTrack?> get subtitle async =>
      _invokeObjectMethod<SubtitleTrack?>(
        Methods.getSubtitle,
        SubtitleTrack.fromJson,
      );

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

class _NativePlayerHandle {
  _NativePlayerHandle(this.methodChannel, this.eventChannel);

  /// Private method channel for this player instance
  MethodChannel methodChannel;

  /// Private method channel for this player instance to receive events
  EventChannel eventChannel;
}
