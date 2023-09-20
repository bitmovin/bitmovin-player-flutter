import 'package:bitmovin_player/bitmovin_player.dart';

// ignore: one_member_abstracts
abstract class AnalyticsApi {
  /// Sends [CustomData] to the analytics backend. The provided [CustomData]
  /// will be merged with previously set [CustomData].
  Future<void> sendCustomDataEvent(CustomData customData);
}
