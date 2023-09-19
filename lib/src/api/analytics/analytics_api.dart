import 'package:bitmovin_player/bitmovin_player.dart';

/// Provides an API to interact with the Analytics collector of a [Player].
// ignore: one_member_abstracts
abstract class AnalyticsApi {
  /// Sends [CustomData] to the analytics backend. The provided [CustomData]
  /// will be merged with previously set [CustomData].
  Future<void> sendCustomDataEvent(CustomData customData);
}
