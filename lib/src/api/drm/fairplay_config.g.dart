// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fairplay_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FairplayConfig _$FairplayConfigFromJson(Map<String, dynamic> json) =>
    FairplayConfig(
      licenseUrl: json['licenseUrl'] as String?,
      certificateUrl: json['certificateUrl'] as String?,
      licenseRequestHeaders:
          (json['licenseRequestHeaders'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      certificateRequestHeaders:
          (json['certificateRequestHeaders'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$FairplayConfigToJson(FairplayConfig instance) =>
    <String, dynamic>{
      'licenseUrl': instance.licenseUrl,
      'certificateUrl': instance.certificateUrl,
      'licenseRequestHeaders': instance.licenseRequestHeaders,
      'certificateRequestHeaders': instance.certificateRequestHeaders,
    };
