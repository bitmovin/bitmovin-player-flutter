// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'casting_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteControlConfig _$RemoteControlConfigFromJson(Map<String, dynamic> json) =>
    RemoteControlConfig(
      receiverStylesheetUrl: json['receiverStylesheetUrl'] as String?,
      customReceiverConfig:
          (json['customReceiverConfig'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, e as String),
              ) ??
              const {},
      isCastEnabled: json['isCastEnabled'] as bool? ?? true,
      sendManifestRequestsWithCredentials:
          json['sendManifestRequestsWithCredentials'] as bool? ?? false,
      sendSegmentRequestsWithCredentials:
          json['sendSegmentRequestsWithCredentials'] as bool? ?? false,
      sendDrmLicenseRequestsWithCredentials:
          json['sendDrmLicenseRequestsWithCredentials'] as bool? ?? false,
    );

Map<String, dynamic> _$RemoteControlConfigToJson(
        RemoteControlConfig instance) =>
    <String, dynamic>{
      'receiverStylesheetUrl': instance.receiverStylesheetUrl,
      'customReceiverConfig': instance.customReceiverConfig,
      'isCastEnabled': instance.isCastEnabled,
      'sendManifestRequestsWithCredentials':
          instance.sendManifestRequestsWithCredentials,
      'sendSegmentRequestsWithCredentials':
          instance.sendSegmentRequestsWithCredentials,
      'sendDrmLicenseRequestsWithCredentials':
          instance.sendDrmLicenseRequestsWithCredentials,
    };

BitmovinCastManagerOptions _$BitmovinCastManagerOptionsFromJson(
        Map<String, dynamic> json) =>
    BitmovinCastManagerOptions(
      applicationId: json['applicationId'] as String?,
      messageNamespace: json['messageNamespace'] as String?,
    );

Map<String, dynamic> _$BitmovinCastManagerOptionsToJson(
        BitmovinCastManagerOptions instance) =>
    <String, dynamic>{
      'applicationId': instance.applicationId,
      'messageNamespace': instance.messageNamespace,
    };
