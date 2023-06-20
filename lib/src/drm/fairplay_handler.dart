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
      case Methods.fairplayPrepareCertificate:
        return _handlePrepareCertificate(arguments);
      case Methods.fairplayPrepareLicense:
        return _handlePrepareLicense(arguments);
      case Methods.fairplayPrepareLicenseServerUrl:
        return _handlePrepareLicenseServerUrl(arguments);
      case Methods.fairplayPrepareSyncMessage:
        return _handlePrepareSyncMessage(arguments);
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

  String? _handlePrepareCertificate(Map<String, String> arguments) {
    final certificate = arguments['certificate'];

    if (certificate == null) {
      return null;
    }

    return fairplayConfig.prepareCertificate?.call(certificate);
  }

  String? _handlePrepareLicense(Map<String, String> arguments) {
    final ckcData = arguments['ckc'];

    if (ckcData == null) {
      return null;
    }

    return fairplayConfig.prepareLicense?.call(ckcData);
  }

  String? _handlePrepareLicenseServerUrl(Map<String, String> arguments) {
    final licenseServerUrl = arguments['licenseServerUrl'];

    if (licenseServerUrl == null) {
      return null;
    }

    return fairplayConfig.prepareLicenseServerUrl?.call(licenseServerUrl);
  }

  String? _handlePrepareSyncMessage(Map<String, String> arguments) {
    final syncSpcData = arguments['syncSpcData'];
    final assetId = arguments['assetId'];

    if (syncSpcData == null || assetId == null) {
      return null;
    }

    return fairplayConfig.prepareSyncMessage?.call(syncSpcData, assetId);
  }
}
