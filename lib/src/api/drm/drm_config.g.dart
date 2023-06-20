// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drm_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrmConfig _$DrmConfigFromJson(Map<String, dynamic> json) => DrmConfig(
      fairplay: json['fairplay'] == null
          ? null
          : FairplayConfig.fromJson(json['fairplay'] as Map<String, dynamic>),
      widevine: json['widevine'] == null
          ? null
          : WidevineConfig.fromJson(json['widevine'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DrmConfigToJson(DrmConfig instance) => <String, dynamic>{
      'fairplay': instance.fairplay?.toJson(),
      'widevine': instance.widevine?.toJson(),
    };
