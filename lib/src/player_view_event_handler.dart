import 'package:bitmovin_player/bitmovin_player.dart';

mixin PlayerViewEventHandler {
  void Function(FullscreenEnterEvent)? get onFullscreenEnter;
  void Function(FullscreenExitEvent)? get onFullscreenExit;
  void Function(PictureInPictureEnterEvent)? get onPictureInPictureEnter;
  void Function(PictureInPictureEnteredEvent)? get onPictureInPictureEntered;
  void Function(PictureInPictureExitEvent)? get onPictureInPictureExit;
  void Function(PictureInPictureExitedEvent)? get onPictureInPictureExited;

  /// Takes an [Event] and emits it to the corresponding event listener.
  void onEvent(Event event) {
    if (event is FullscreenEnterEvent) {
      onFullscreenEnter?.call(event);
    } else if (event is FullscreenExitEvent) {
      onFullscreenExit?.call(event);
    } else if (event is PictureInPictureEnterEvent) {
      onPictureInPictureEnter?.call(event);
    } else if (event is PictureInPictureEnteredEvent) {
      onPictureInPictureEntered?.call(event);
    } else if (event is PictureInPictureExitEvent) {
      onPictureInPictureExit?.call(event);
    } else if (event is PictureInPictureExitedEvent) {
      onPictureInPictureExited?.call(event);
    }
  }
}
