import 'dart:async';
import 'dart:convert';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/channel_manager.dart';
import 'package:bitmovin_player/src/channels.dart';
import 'package:bitmovin_player/src/methods.dart';
import 'package:bitmovin_player/src/platform/player_platform_interface.dart';
import 'package:flutter/services.dart';

/// An implementation of [PlayerPlatformInterface] that uses method channels.
/// Is specific to a single player instance.
class PlayerPlatformMethodChannel extends PlayerPlatformInterface {
  PlayerPlatformMethodChannel(
    this._playerId,
    this.config,
    this._onPlatformEvent,
  ) {
    _methodChannel = ChannelManager.registerMethodChannel(
      name: '${Channels.player}-$_playerId',
      handler: _playerMethodCallHandler,
    );
    _eventChannel = ChannelManager.registerEventChannel(
      name: '${Channels.playerEvent}-$_playerId',
    );
  }

  /// Unique identifier for this player instance.
  final String _playerId;

  @override
  final PlayerConfig config;

  final void Function(dynamic event) _onPlatformEvent;

  // ignore: avoid_positional_boolean_parameters
  void nativePlayerInitialized(bool? success) {
    _eventChannel.receiveBroadcastStream().listen(_onPlatformEvent);
    _completer.complete(success);
  }

  /// Whether the player has been created successfully on the native platform
  /// side. If `true`, the player is ready to be used. If `false`, there was an
  /// error during player creation on the native platform side.
  late final Future<bool> _initializationResult = _completer.future;

  /// Used to generate the [_initializationResult] future.
  final _completer = Completer<bool>();

  /// Private method channel for this player instance
  late MethodChannel _methodChannel;

  /// Private method channel for this player instance to receive events
  late EventChannel _eventChannel;

  Future<String?> _playerMethodCallHandler(MethodCall methodCall) async {
    switch (methodCall.method) {
      case Methods.fairplayPrepareMessage:
      case Methods.fairplayPrepareContentId:
      case Methods.fairplayPrepareCertificate:
      case Methods.fairplayPrepareLicense:
      case Methods.fairplayPrepareLicenseServerUrl:
      case Methods.fairplayPrepareSyncMessage:
        return fairplayHandler?.handleMethodCall(methodCall);
      case Methods.widevinePrepareMessage:
      case Methods.widevinePrepareLicense:
        return widevineHandler?.handleMethodCall(methodCall);
      default:
        throw UnsupportedError('Unsupported method ${methodCall.method}');
    }
  }

  Map<String, dynamic> _buildPayload([dynamic data]) {
    return Map<String, dynamic>.from({
      'id': _playerId,
      'data': data,
    });
  }

  // Can be used to call methods on the platform side that return a single
  // primitive value that is natively supported by the method channel.
  Future<T> _invokeMethod<T>(
    String methodName, [
    dynamic data,
  ]) async {
    final initSuccess = await _initializationResult;
    if (!initSuccess) {
      throw Exception('Error initializing player on native platform side.');
    }

    final payload = _buildPayload(data);
    final result = await _methodChannel.invokeMethod<T>(methodName, payload);
    if (result is! T) {
      // result is T?, if it `is` not T => T is not nullable and result is null.
      throw Exception('Native $methodName returned null.');
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
    final initSuccess = await _initializationResult;
    if (!initSuccess) {
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
    final initSuccess = await _initializationResult;
    if (!initSuccess) {
      throw Exception('Error initializing player on native platform side.');
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
  Future<List<SubtitleTrack>> get availableSubtitles async =>
      _invokeListObjectsMethod<SubtitleTrack>(
        Methods.availableSubtitles,
        SubtitleTrack.fromJson,
      );

  @override
  Future<void> castStop() async => _invokeMethod<void>(Methods.castStop);

  @override
  Future<void> castVideo() async => _invokeMethod<void>(Methods.castVideo);

  @override
  Future<double> get currentTime async =>
      _invokeMethod<double>(Methods.currentTime);

  @override
  Future<double> get duration async => _invokeMethod<double>(Methods.duration);

  @override
  Future<bool> get isAirPlayActive async =>
      _invokeMethod(Methods.isAirPlayActive);

  @override
  Future<bool> get isAirPlayAvailable async =>
      _invokeMethod(Methods.isAirPlayAvailable);

  @override
  Future<bool> get isCastAvailable async =>
      _invokeMethod(Methods.isCastAvailable);

  @override
  Future<bool> get isCasting async => _invokeMethod(Methods.isCasting);

  @override
  Future<bool> get isLive async => _invokeMethod<bool>(Methods.isLive);

  @override
  Future<bool> get isPlaying async => _invokeMethod<bool>(Methods.isPlaying);

  @override
  Future<void> loadSource(Source source) {
    super.loadSource(source);
    return _invokeMethod<void>(Methods.loadWithSource, source.toJson());
  }

  @override
  Future<double> get maxTimeShift async =>
      _invokeMethod<double>(Methods.maxTimeShift);

  @override
  Future<void> mute() async => _invokeMethod<void>(Methods.mute);

  @override
  Future<void> pause() async => _invokeMethod<void>(Methods.pause);

  @override
  Future<void> play() => _invokeMethod<void>(Methods.play);

  @override
  Future<void> removeSubtitle(String id) async =>
      _invokeMethod<void>(Methods.removeSubtitle, id);

  @override
  Future<void> seek(double time) async =>
      _invokeMethod<void>(Methods.seek, time);

  @override
  Future<void> setSubtitle(String? id) async =>
      _invokeMethod<void>(Methods.setSubtitle, id);

  @override
  Future<void> setTimeShift(double timeShift) async =>
      _invokeMethod<void>(Methods.setTimeShift, timeShift);

  @override
  Future<void> showAirPlayTargetPicker() async =>
      _invokeMethod<void>(Methods.showAirPlayTargetPicker);

  @override
  Future<SubtitleTrack> get subtitle async =>
      await _invokeObjectMethod<SubtitleTrack>(
        Methods.getSubtitle,
        SubtitleTrack.fromJson,
      ) ??
      SubtitleTrack.off();

  @override
  Future<double> get timeShift async =>
      _invokeMethod<double>(Methods.getTimeShift);

  @override
  Future<void> unmute() async => _invokeMethod<void>(Methods.unmute);

  @override
  Future<void> dispose() async => _invokeMethod<void>(Methods.destroy);

  @override
  Future<void> sendCustomDataEvent(CustomData customData) async =>
      _invokeMethod<void>(Methods.sendCustomDataEvent, customData.toJson());
}
