// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widevine_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WidevineConfig _$WidevineConfigFromJson(Map<String, dynamic> json) =>
    WidevineConfig(
      licenseUrl: json['licenseUrl'] as String?,
      httpHeaders: (json['httpHeaders'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      preferredSecurityLevel: json['preferredSecurityLevel'] as String?,
      shouldKeepDrmSessionsAlive:
          json['shouldKeepDrmSessionsAlive'] as bool? ?? false,
    );

Map<String, dynamic> _$WidevineConfigToJson(WidevineConfig instance) =>
    <String, dynamic>{
      'licenseUrl': instance.licenseUrl,
      'httpHeaders': instance.httpHeaders,
      'preferredSecurityLevel': instance.preferredSecurityLevel,
      'shouldKeepDrmSessionsAlive': instance.shouldKeepDrmSessionsAlive,
    };
