import 'package:bitmovin_player/bitmovin_player.dart';

/// Provides access to GoogleCast related features of [Player]s.
// ignore: one_member_abstracts
abstract class BitmovinCastManagerApi {
  /// Sends the given `message` to the cast receiver.
  /// On Android and iOS an optional `messageNamespace` can be provided on which
  /// the message should be sent. Should there be a `messageNamespace` provided
  /// on Web, it will be ignored.
  Future<void> sendMessage({
    required String message,
    String? messageNamespace,
  });
}
