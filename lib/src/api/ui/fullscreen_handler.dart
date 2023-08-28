import 'package:bitmovin_player/src/player_view.dart';

/// Handles the UI state change when fullscreen should be entered or exited.
abstract class FullscreenHandler {
  /// Indicates whether the UI is currently in fullscreen mode.
  bool get isFullscreen;

  /// Is called by the [PlayerView] when the UI should enter fullscreen mode.
  /// Do not call this directly to enter fullscreen. Call
  /// [PlayerViewState.enterFullscreen] instead if you want to enter fullscreen
  /// programmatically.
  void enterFullscreen();

  /// Is called by the [PlayerView] when the UI should exit fullscreen mode.
  /// Do not call this directly to exit fullscreen. Call
  /// [PlayerViewState.exitFullscreen] instead if you want to exit fullscreen
  /// programmatically.
  void exitFullscreen();
}
