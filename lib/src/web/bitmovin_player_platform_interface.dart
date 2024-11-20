import 'package:bitmovin_player/src/web/bitmovin_player_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class BitmovinPlayerPlatform extends PlatformInterface {
  /// Constructs a BitmovinPlayerPlatform.
  BitmovinPlayerPlatform() : super(token: _token);

  static final Object _token = Object();

  static BitmovinPlayerPlatform _instance = MethodChannelBitmovinPlayer();

  /// The default instance of [BitmovinPlayerPlatform] to use.
  ///
  /// Defaults to [MethodChannelBitmovinPlayer].
  static BitmovinPlayerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BitmovinPlayerPlatform] when
  /// they register themselves.
  static set instance(BitmovinPlayerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
