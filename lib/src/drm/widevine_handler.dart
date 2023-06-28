import 'package:bitmovin_player/src/api/drm/widevine_config.dart';
import 'package:bitmovin_player/src/methods.dart';
import 'package:flutter/services.dart';

class WidevineHandler {
  WidevineHandler(this.widevineConfig);

  final WidevineConfig widevineConfig;

  String? handleMethodCall(MethodCall methodCall) {
    final arguments =
        (methodCall.arguments as Map<dynamic, dynamic>).cast<String, String>();

    switch (methodCall.method) {
      case Methods.widevinePrepareMessage:
        return _handlePrepareMessage(arguments);
      case Methods.widevinePrepareLicense:
        return _handlePrepareLicense(arguments);
    }

    return null;
  }

  String? _handlePrepareMessage(Map<String, String> arguments) {
    final keyMessageBase64 = arguments['keyMessage'];

    if (keyMessageBase64 == null) {
      return null;
    }

    return widevineConfig.prepareMessage?.call(keyMessageBase64);
  }

  String? _handlePrepareLicense(Map<String, String> arguments) {
    final licenseResponseBase64 = arguments['licenseResponse'];

    if (licenseResponseBase64 == null) {
      return null;
    }

    return widevineConfig.prepareLicense?.call(licenseResponseBase64);
  }
}
