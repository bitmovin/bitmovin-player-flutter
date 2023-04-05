import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

abstract class EventListener {
  final EventChannel eventChannel =
      const EventChannel('com.bitmovin/player_events');

  /// Listen to the events that player emits.
  Stream<dynamic> eventStream() {
    return eventChannel.receiveBroadcastStream().map<dynamic>((event) {
      debugPrint('CLIENT APP ==> $event');
      return event;
    }
        // (event) => PlayerEventPayload.fromJson(
        //   Map<String, dynamic>.from(event),
        // ),
        );
  }
}
