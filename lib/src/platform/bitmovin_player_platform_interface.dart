import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/platform/bitmovin_player_platform_method_channel.dart';
import 'package:bitmovin_player/src/platform/player_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// The main platform interface that is used to interact with the platform
/// plugins. This is not specific to a player or player view instance.
// TODO(mario): rename to match file name.
abstract class BitmovinPlayerPlatform extends PlatformInterface {
  /// Constructs a [BitmovinPlayerPlatform].
  BitmovinPlayerPlatform() : super(token: _token);

  static final Object _token = Object();

  static BitmovinPlayerPlatform _instance =
      BitmovinPlayerPlatformMethodChannel();

  /// The instance of [BitmovinPlayerPlatform] to use.
  ///
  /// Defaults to [BitmovinPlayerPlatformMethodChannel].
  static BitmovinPlayerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BitmovinPlayerPlatform] when
  /// they register themselves.
  static set instance(BitmovinPlayerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Creates a new player instance with the given [id] and [config].
  PlayerPlatformInterface createPlayer(
    String id,
    PlayerConfig config,
    void Function(dynamic event) onPlatformEvent,
  ) {
    throw UnimplementedError('createPlayer() has not been implemented.');
  }
}
