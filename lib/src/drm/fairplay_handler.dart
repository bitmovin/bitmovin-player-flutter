import 'package:bitmovin_sdk/src/api/drm/fairplay_config.dart';
import 'package:bitmovin_sdk/src/methods.dart';
import 'package:flutter/services.dart';

class FairplayHandler {
  FairplayHandler(this.fairplayConfig);

  final FairplayConfig fairplayConfig;

  String? handleMethodCall(MethodCall methodCall) {
    final arguments =
        (methodCall.arguments as Map<dynamic, dynamic>).cast<String, String>();

    switch (methodCall.method) {
      case Methods.fairplayPrepareMessage:
        return _handlePrepareMessage(arguments);
    }

    return null;
  }

  String? _handlePrepareMessage(Map<String, String> arguments) {
    final spcDataBase64 = arguments['spcData'] ?? '';
    final assetId = arguments['assetId'] ?? '';

    return fairplayConfig.prepareMessage?.call(spcDataBase64, assetId);
  }
}
