import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/platform/cast_manager_platform_interface.dart';

/// Singleton, providing access to GoogleCast related features.
/// Retrieve the singleton instance using [initialize].
class BitmovinCastManager implements BitmovinCastManagerApi {
  BitmovinCastManager._(); // private constructor
  static BitmovinCastManager? _singleton;

  /// Initialize [BitmovinCastManager] based on the provided
  /// [BitmovinCastManagerOptions].
  /// This method needs to be called before [Player] creation to enable casting
  /// features.
  /// If no options are provided, the default options will be used.
  ///
  /// IMPORTANT: On iOS and Android, this should only be called when the
  /// Google Cast SDK is available and linked in the application.
  /// For Web, loading the CAST SDK is handled automatically.
  static Future<BitmovinCastManager> initialize({
    BitmovinCastManagerOptions options = const BitmovinCastManagerOptions(),
  }) async {
    final singleton = _singleton;
    if (singleton != null) {
      return singleton;
    }
    final instance = BitmovinCastManager._();
    await instance._initialize(options);
    return _singleton = instance;
  }

  Future<void> _initialize(BitmovinCastManagerOptions options) =>
      CastManagerPlatformInterface.instance.initializeCastManager(options);

  @override
  Future<void> sendMessage({
    required String message,
    String? messageNamespace,
  }) =>
      CastManagerPlatformInterface.instance.sendMessage(
        message: message,
        messageNamespace: messageNamespace,
      );
}
