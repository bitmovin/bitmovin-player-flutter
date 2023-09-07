import 'package:bitmovin_player/bitmovin_player.dart';

// ignore: one_member_abstracts
abstract class AnalyticsApi {
  Future<void> sendCustomDataEvent(CustomData customData);
}
