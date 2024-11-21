import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/channel_manager.dart';
import 'package:bitmovin_player/src/channels.dart';
import 'package:bitmovin_player/src/methods.dart';
import 'package:bitmovin_player/src/platform/bitmovin_player_platform_interface.dart';

/// An implementation of [BitmovinPlayerPlatform] that uses method channels.
/// This is not specific to a player or player view instance and is currently
/// used for iOS and Android.
class BitmovinPlayerPlatformMethodChannel extends BitmovinPlayerPlatform {
  /// The method channel used to interact with the native platform.
  final mainChannel = ChannelManager.registerMethodChannel(
    name: Channels.main,
  );

  @override
  Future<bool?> createPlayer(String id, PlayerConfig config) async {
    return mainChannel.invokeMethod<bool>(
      Methods.createPlayer,
      Map<String, dynamic>.from(
        {
          'id': id,
          'playerConfig': config.toJson(),
        },
      ),
    );
  }
}
