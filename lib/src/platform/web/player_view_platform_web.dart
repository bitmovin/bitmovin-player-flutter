import 'package:bitmovin_player/src/channels.dart';
import 'package:bitmovin_player/src/platform.dart';
import 'package:bitmovin_player/src/platform/player_view_platform_interface.dart';
import 'package:flutter/widgets.dart';

/// An implementation of [PlayerViewPlatformInterface] for the Web platform.
/// This is specific to a single player view instance.
class PlayerViewPlatformWeb extends PlayerViewPlatformInterface {
  PlayerViewPlatformWeb(
    this._handleEnterFullscreen,
    this._handleExitFullscreen,
    this._onViewCreated,
  );

  final void Function() _handleEnterFullscreen;
  final void Function() _handleExitFullscreen;
  final void Function()? _onViewCreated;

  @override
  Widget build(BuildContext context, Map<String, dynamic> creationParams) {
    if (isWeb) {
      return _buildForWeb(context, creationParams);
    } else {
      throw UnsupportedError(
        'Cannot build player view widget: Unsupported platform.',
      );
    }
  }

  @override
  void dispose() {/* no-op for web */}

  // TODO(mario): implement view mode support
  @override
  Future<void> enterFullscreen() async => _handleEnterFullscreen();

  // TODO(mario): implement view mode support
  @override
  Future<void> exitFullscreen() async => _handleExitFullscreen();

  @override
  Future<void> enterPictureInPicture() {
    // TODO(mario): implement view mode support
    return Future.value();
  }

  @override
  Future<void> exitPictureInPicture() async {
    // TODO(mario): implement view mode support
    return Future.value();
  }

  @override
  // TODO(mario): implement view mode support
  Future<bool> get isPictureInPicture async => false;

  @override
  // TODO(mario): implement view mode support
  Future<bool> get isPictureInPictureAvailable async => false;

  Widget _buildForWeb(
    BuildContext context,
    Map<String, dynamic> creationParams,
  ) {
    return HtmlElementView(
      viewType: Channels.playerView,
      key: UniqueKey(),
      creationParams: creationParams,
      onPlatformViewCreated: (id) {
        _onViewCreated?.call();
      },
    );
  }
}
