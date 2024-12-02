import 'package:bitmovin_player/src/api/casting/bitmovin_cast_manager_options.dart';
import 'package:bitmovin_player/src/casting/custom_cast_message.dart';
import 'package:bitmovin_player/src/channel_manager.dart';
import 'package:bitmovin_player/src/channels.dart';
import 'package:bitmovin_player/src/methods.dart';
import 'package:bitmovin_player/src/platform/cast_manager_platform_interface.dart';

/// An implementation of [CastManagerPlatformInterface] that uses method
/// channels. This is currently used for iOS and Android.
class CastManagerPlatformMessageChannel extends CastManagerPlatformInterface {
  final _mainChannel = ChannelManager.registerMethodChannel(
    name: Channels.main,
  );

  @override
  Future<void> sendMessage({
    required String message,
    String? messageNamespace,
  }) =>
      _mainChannel.invokeMethod<void>(
        Methods.castManagerSendMessage,
        CustomCastMessage(
          message: message,
          messageNamespace: messageNamespace,
        ).toJson(),
      );

  @override
  Future<void> initializeCastManager(BitmovinCastManagerOptions options) {
    return _mainChannel.invokeMethod<void>(
      Methods.castManagerInitialize,
      options.toJson(),
    );
  }
}
