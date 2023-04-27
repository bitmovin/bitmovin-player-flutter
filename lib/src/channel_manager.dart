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
}
