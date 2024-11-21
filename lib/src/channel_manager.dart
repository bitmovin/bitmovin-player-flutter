import 'package:flutter/services.dart';

class ChannelManager {
  ChannelManager();

  static MethodChannel registerMethodChannel({
    required String name,
    Future<dynamic> Function(MethodCall)? handler,
  }) {
    final target = MethodChannel(name);
    if (handler != null) {
      target.setMethodCallHandler(handler);
    }
    return target;
  }

  static EventChannel registerEventChannel({required String name}) {
    return EventChannel(name);
  }
}
