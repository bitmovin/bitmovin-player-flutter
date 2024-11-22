import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/channel_manager.dart';
import 'package:bitmovin_player/src/channels.dart';
import 'package:bitmovin_player/src/methods.dart';
import 'package:bitmovin_player/src/platform/bitmovin_player_platform_interface.dart';
import 'package:bitmovin_player/src/platform/player_platform_interface.dart';
import 'package:bitmovin_player/src/platform/player_platform_method_channel.dart';

/// An implementation of [BitmovinPlayerPlatformInterface] that uses method
/// channels. This is not specific to a player or player view instance and is
/// currently used for iOS and Android.
class BitmovinPlayerPlatformMethodChannel
    extends BitmovinPlayerPlatformInterface {
  /// The method channel used to interact with the native platform.
  final mainChannel = ChannelManager.registerMethodChannel(
    name: Channels.main,
  );

  @override
  PlayerPlatformInterface createPlayer(
    String id,
    PlayerConfig config,
    void Function(Event event) onPlatformEvent,
  ) {
    final playerPlatformInterface =
        PlayerPlatformMethodChannel(id, config, onPlatformEvent);

    mainChannel
        .invokeMethod<bool>(
          Methods.createPlayer,
          Map<String, dynamic>.from(
            {
              'id': id,
              'playerConfig': config.toJson(),
            },
          ),
        )
        .then(playerPlatformInterface.nativePlayerInitialized);

    return playerPlatformInterface;
  }
}
