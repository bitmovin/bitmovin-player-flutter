import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/platform/bitmovin_player_platform_interface.dart';
import 'package:bitmovin_player/src/platform/player_view_platform_interface.dart';
import 'package:bitmovin_player/src/player_view_event_handler.dart';
import 'package:flutter/widgets.dart';

/// A view that provides the Bitmovin Player Web UI and default UI handling to
/// an attached [Player] instance.
class PlayerView extends StatefulWidget with PlayerViewEventHandler {
  PlayerView({
    required this.player,
    this.playerViewConfig = const PlayerViewConfig(),
    super.key,
    this.onViewCreated,
    this.fullscreenHandler,
    this.onFullscreenEnter,
    this.onFullscreenExit,
    this.onPictureInPictureEnter,
    this.onPictureInPictureEntered,
    this.onPictureInPictureExit,
    this.onPictureInPictureExited,
  });

  /// The [Player] instance that is attached to this view.
  final Player player;

  /// The player view config.
  /// A default [PlayerViewConfig] is set initially.
  final PlayerViewConfig playerViewConfig;

  /// Callback that is invoked when the view has been created and is ready to be
  /// used. Can be for instance used to load a source into the [player].
  final void Function()? onViewCreated;

  /// Handles entering and exiting fullscreen mode. A custom implementation
  /// needs to be provided that is aware of the view hierarchy where the
  /// [PlayerView] is embedded and can handle the UI state changes accordingly.
  /// If no [fullscreenHandler] is provided, the fullscreen feature is disabled.
  final FullscreenHandler? fullscreenHandler;

  @override
  final void Function(FullscreenEnterEvent)? onFullscreenEnter;

  @override
  final void Function(FullscreenExitEvent)? onFullscreenExit;

  @override
  final void Function(PictureInPictureEnterEvent)? onPictureInPictureEnter;

  @override
  final void Function(PictureInPictureEnteredEvent)? onPictureInPictureEntered;

  @override
  final void Function(PictureInPictureExitEvent)? onPictureInPictureExit;

  @override
  final void Function(PictureInPictureExitedEvent)? onPictureInPictureExited;

  @override
  State<StatefulWidget> createState() => PlayerViewState();
}

/// Provides the state for a [PlayerView].
class PlayerViewState extends State<PlayerView> {
  PlayerViewState() {
    // Do not pass references to the widget's functions to the platform
    // interface as the widget might get re-built on state changes and the
    // references could change and become invalid.
    _playerViewPlatformInterface =
        BitmovinPlayerPlatformInterface.instance.createPlayerView(
      onPlatformEvent: (Event event) => widget.onEvent(event),
      handleEnterFullscreen: () => widget.fullscreenHandler?.enterFullscreen(),
      handleExitFullscreen: () => widget.fullscreenHandler?.exitFullscreen(),
      onViewCreated: () => widget.onViewCreated?.call(),
    );
  }

  /// Interface to the platform-specific player implementation.
  late final PlayerViewPlatformInterface _playerViewPlatformInterface;

  /// Returns whether the [PlayerView] is currently in fullscreen mode.
  bool get isFullscreen => widget.fullscreenHandler?.isFullscreen ?? false;

  /// Enters fullscreen mode for the [PlayerView].
  void enterFullscreen() => _playerViewPlatformInterface.enterFullscreen();

  /// Exits fullscreen mode for the [PlayerView].
  void exitFullscreen() => _playerViewPlatformInterface.exitFullscreen();

  /// Access Picture-in-Picture APIs.
  PictureInPictureApi get pictureInPicture =>
      _playerViewPlatformInterface.pictureInPicture;

  @override
  void dispose() {
    _playerViewPlatformInterface.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final creationParams = {
      'playerId': widget.player.id,
      'hasFullscreenHandler': widget.fullscreenHandler != null,
      'isFullscreen': isFullscreen,
      'playerViewConfig': widget.playerViewConfig.toJson(),
    };

    return _playerViewPlatformInterface.build(context, creationParams);
  }
}
