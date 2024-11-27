import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/platform/cast_manager_platform_message_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// Platform interface for the cast manager.
abstract class CastManagerPlatformInterface extends PlatformInterface
    implements BitmovinCastManagerApi {
  /// Constructs a [CastManagerPlatformInterface].
  CastManagerPlatformInterface() : super(token: _token);

  static final Object _token = Object();

  static CastManagerPlatformInterface _instance =
      CastManagerPlatformMessageChannel();

  /// The instance of [CastManagerPlatformInterface] to use.
  ///
  /// Defaults to [CastManagerPlatformMessageChannel].
  static CastManagerPlatformInterface get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CastManagerPlatformInterface]
  /// when they register themselves.
  static set instance(CastManagerPlatformInterface instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Initializes the cast manager with the given [options].
  Future<void> initializeCastManager(BitmovinCastManagerOptions options);
}
