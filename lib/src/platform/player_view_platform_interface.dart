import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:flutter/widgets.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// The player view platform interface that is used to interact with the
/// platform plugins. Manages a single player view instance.
abstract class PlayerViewPlatformInterface extends PlatformInterface
    implements PictureInPictureApi {
  /// Constructs a [PlayerViewPlatformInterface].
  PlayerViewPlatformInterface() : super(token: Object());

  PictureInPictureApi get pictureInPicture => _PictureInPictureApi(this);
  Widget build(BuildContext context, Map<String, dynamic> creationParams);
  void enterFullscreen();
  void exitFullscreen();
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
