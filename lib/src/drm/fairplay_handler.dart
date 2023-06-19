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
      case Methods.fairplayPrepareContentId:
        return _handlePrepareContentId(arguments);
    }

    return null;
  }

  String? _handlePrepareMessage(Map<String, String> arguments) {
    final spcDataBase64 = arguments['spcData'];
    final assetId = arguments['assetId'];

    if (spcDataBase64 == null || assetId == null) {
      return null;
    }

    return fairplayConfig.prepareMessage?.call(spcDataBase64, assetId);
  }

  String? _handlePrepareContentId(Map<String, String> arguments) {
    final contentId = arguments['contentId'];

    if (contentId == null) {
      return null;
    }

    return fairplayConfig.prepareContentId?.call(contentId);
  }
}
