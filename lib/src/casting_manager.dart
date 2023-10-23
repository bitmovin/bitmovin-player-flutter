import 'dart:io';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/casting/casting_config.dart';
import 'package:bitmovin_player/src/channel_manager.dart';
import 'package:bitmovin_player/src/channels.dart';
import 'package:bitmovin_player/src/methods.dart';

/// Singleton providing access to GoogleCast related features.
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
  /// IMPORTANT: This should only be called when the Google Cast SDK is
  /// available in the application.
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

  final _mainChannel = ChannelManager.registerMethodChannel(
    name: Channels.main,
  );

  Future<void> _initialize(BitmovinCastManagerOptions options) =>
      _mainChannel.invokeMethod<void>(
          Methods.castManagerInitialize,
          options.toJson(),
      );

  @override
  Future<void> sendMessage({
    required String message,
    String? messageNamespace,
  }) => _mainChannel.invokeMethod<void>(
    Methods.castManagerSendMessage,
    BitmovinCastManagerSendMessage(
        message: message,
        messageNamespace: messageNamespace,
    ).toJson(),
  );

  @override
  Future<void> updateContext() async {
    if (Platform.isIOS) {
      return;
    }
    return _mainChannel.invokeMethod(Methods.castManagerUpdateContext);
  }
}
