import 'package:bitmovin_player/bitmovin_player.dart';

/// Provides access to GoogleCast related features of [Player]s.
abstract class BitmovinCastManagerApi {
  /// Must be called in every Android Activity to update the context to the
  /// current one.
  /// Only supported on Android.
  Future<void> updateContext();

  /// Sends the given message to the cast receiver.
  Future<void> sendMessage({
    required String message,
    String? messageNamespace,
  });
}
