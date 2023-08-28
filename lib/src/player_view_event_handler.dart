import 'dart:convert';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:logger/logger.dart';

mixin PlayerViewEventHandler {
  final Logger _logger = Logger();

  void Function(FullscreenEnterEvent)? get onFullscreenEnter;
  void Function(FullscreenExitEvent)? get onFullscreenExit;

  /// Takes an event as JSON that was received from the native platform,
  /// deserializes it to a typed event object and emits it to the corresponding
  /// event listener.
  void onEvent(dynamic event) {
    if (event == null || event is! String) {
      _logger.e('Received event is null');
      return;
    }

    final target = jsonDecode(event) as Map<String, dynamic>;
    final eventName = target['event'];
    final data = target['data'];

    if (eventName is! String || data is! Map<String, dynamic>) {
      _logger.e('Could not find valid event data');
      return;
    }

    switch (eventName) {
      case 'onFullscreenEnter':
        onFullscreenEnter?.call(FullscreenEnterEvent.fromJson(data));
        break;
      case 'onFullscreenExit':
        onFullscreenExit?.call(FullscreenExitEvent.fromJson(data));
        break;
    }
  }
}
