import 'package:bitmovin_player/bitmovin_player.dart';

/// Provides access to GoogleCast related features of [Player]s.
// ignore: one_member_abstracts
abstract class BitmovinCastManagerApi {
  /// Sends the given `message` to the cast receiver.
  Future<void> sendMessage({
    required String message,
    String? messageNamespace,
  });
}
