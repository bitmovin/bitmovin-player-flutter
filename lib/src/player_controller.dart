// ignore_for_file: avoid_print

import 'package:bitmovin_sdk/player.dart';
import 'package:bitmovin_sdk/src/channels.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

abstract class IPlayerControl {
  Future<void> play();

  Future<void> pause();

  Future<void> loadWithSourceConfig(SourceConfig config);
  Future<void> loadWithSource(Source source);

  Future<void> unload();

  Future<void> destroy();

  Future<void> seek();

  Future<void> mute();

  Future<void> unmute();
}

class PlayerController implements IPlayerControl {
  PlayerController({
    required this.id,
  })  : _methodChannel = MethodChannel('${Channels.methods}-$id'),
        _eventChannel = EventChannel('${Channels.events}-$id') {
    _eventChannel.receiveBroadcastStream().listen((value) {
      debugPrint('GOT VALUE ==> $value');
    });
  }

  final MethodChannel _methodChannel;
  final EventChannel _eventChannel;

  final int id;

  @override
  Future<void> play() async {
    await _methodChannel.invokeMethod('play');
  }

  @override
  Future<void> pause() async {
    await _methodChannel.invokeMethod('pause');
  }

  @override
  Future<void> loadWithSourceConfig(SourceConfig config) async {
    await _methodChannel.invokeMethod('loadWithSourceConfig', config.toJson());
  }

  @override
  Future<void> loadWithSource(Source source) async {
    await _methodChannel.invokeMethod('loadWithSource', source.toJson());
  }

  @override
  Future<void> unload() async {
    await _methodChannel.invokeMethod('unload');
  }

  @override
  Future<void> destroy() async {
    await _methodChannel.invokeMethod('destroy');
  }

  @override
  Future<void> seek() async {
    await _methodChannel.invokeMethod('seek');
  }

  @override
  Future<void> mute() async {
    await _methodChannel.invokeMethod('mute');
  }

  @override
  Future<void> unmute() async {
    await _methodChannel.invokeMethod('unmute');
  }

  void onSourceLoaded(Function func) {}

  /// Listen to the events that player emits.
  void eventStream() {
    // return _eventChannel.receiveBroadcastStream().map<PlayerEventPayload>(
    //       (event) => PlayerEventPayload.fromJson(
    //         Map<String, dynamic>.from(event as Map<String, dynamic>),
    //       ),
    //     );
  }
}
