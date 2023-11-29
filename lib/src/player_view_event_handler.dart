import 'dart:convert';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:logger/logger.dart';

mixin PlayerViewEventHandler {
  final Logger _logger = Logger();

  void Function(FullscreenEnterEvent)? get onFullscreenEnter;
  void Function(FullscreenExitEvent)? get onFullscreenExit;
  void Function(PictureInPictureEnterEvent)? get onPictureInPictureEnter;
  void Function(PictureInPictureEnteredEvent)? get onPictureInPictureEntered;
  void Function(PictureInPictureExitEvent)? get onPictureInPictureExit;
  void Function(PictureInPictureExitedEvent)? get onPictureInPictureExited;

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
      case 'onPictureInPictureEnter':
        onPictureInPictureEnter
            ?.call(PictureInPictureEnterEvent.fromJson(data));
        break;
      case 'onPictureInPictureEntered':
        onPictureInPictureEntered
            ?.call(PictureInPictureEnteredEvent.fromJson(data));
        break;
      case 'onPictureInPictureExit':
        onPictureInPictureExit?.call(PictureInPictureExitEvent.fromJson(data));
        break;
      case 'onPictureInPictureExited':
        onPictureInPictureExited
            ?.call(PictureInPictureExitedEvent.fromJson(data));
        break;
    }
  }
}
