import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:flutter/widgets.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// The platform interface that is used to interact with a single platform
/// specific player view instance.
abstract class PlayerViewPlatformInterface extends PlatformInterface
    implements PictureInPictureApi {
  /// Constructs a [PlayerViewPlatformInterface].
  PlayerViewPlatformInterface() : super(token: Object());

  /// Access Picture-in-Picture APIs.
  PictureInPictureApi get pictureInPicture => _PictureInPictureApi(this);

  /// Creates a platform specific player view, using the provided
  /// [creationParams].
  Widget build(BuildContext context, Map<String, dynamic> creationParams);

  /// Let's the platform specific player view enter fullscreen.
  Future<void> enterFullscreen();

  /// Let's the platform specific player view exit fullscreen.
  Future<void> exitFullscreen();

  /// Disposes the platform specific player view.
  void dispose();
}

class _PictureInPictureApi implements PictureInPictureApi {
  _PictureInPictureApi(this._playerViewPlatformInterface);

  final PlayerViewPlatformInterface _playerViewPlatformInterface;

  @override
  Future<bool> get isPictureInPicture async =>
      _playerViewPlatformInterface.isPictureInPicture;

  @override
  Future<bool> get isPictureInPictureAvailable async =>
      _playerViewPlatformInterface.isPictureInPictureAvailable;

  @override
  Future<void> enterPictureInPicture() async =>
      _playerViewPlatformInterface.enterPictureInPicture();

  @override
  Future<void> exitPictureInPicture() async =>
      _playerViewPlatformInterface.exitPictureInPicture();
}
