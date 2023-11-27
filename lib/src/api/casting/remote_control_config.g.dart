// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_control_config.dart';

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
      isAirPlayEnabled: json['isAirPlayEnabled'] as bool? ?? true,
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
      'isAirPlayEnabled': instance.isAirPlayEnabled,
      'isCastEnabled': instance.isCastEnabled,
      'sendManifestRequestsWithCredentials':
          instance.sendManifestRequestsWithCredentials,
      'sendSegmentRequestsWithCredentials':
          instance.sendSegmentRequestsWithCredentials,
      'sendDrmLicenseRequestsWithCredentials':
          instance.sendDrmLicenseRequestsWithCredentials,
    };
