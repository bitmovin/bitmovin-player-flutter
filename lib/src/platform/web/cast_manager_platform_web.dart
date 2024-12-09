import 'package:bitmovin_player/src/api/casting/bitmovin_cast_manager_options.dart';
import 'package:bitmovin_player/src/platform/cast_manager_platform_interface.dart';

/// An implementation of [CastManagerPlatformInterface] for the Web platform.
class CastManagerPlatformWeb extends CastManagerPlatformInterface {
  BitmovinCastManagerOptions? _options;
  BitmovinCastManagerOptions? get options => _options;
  void Function(String)? castMessageHandler;

  @override
  Future<void> sendMessage({
    required String message,
    String? messageNamespace,
  }) {
    castMessageHandler?.call(message);
    return Future.value();
  }

  @override
  Future<void> initializeCastManager(BitmovinCastManagerOptions options) {
    _options = options;
    return Future.value();
  }
}
