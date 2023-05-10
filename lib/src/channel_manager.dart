import 'package:flutter/services.dart';

class ChannelManager {
  ChannelManager([
    Future<dynamic> Function(MethodCall)? handler,
  ]) {
    _method = const MethodChannel('channel-manager');
    _method.setMethodCallHandler(handler);
  }
  late MethodChannel _method;

  MethodChannel get method => _method;

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
