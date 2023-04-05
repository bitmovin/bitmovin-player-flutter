// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drm_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrmConfig _$DrmConfigFromJson(Map<String, dynamic> json) => DrmConfig(
      licenseUrl: json['license_url'] as String,
      drmLicenseType:
          $enumDecode(_$DrmLicenseTypeEnumMap, json['license_type']),
      hlsCertificateUrl: json['hls_certificate'] as String?,
    );

Map<String, dynamic> _$DrmConfigToJson(DrmConfig instance) => <String, dynamic>{
      'license_url': instance.licenseUrl,
      'license_type': _$DrmLicenseTypeEnumMap[instance.drmLicenseType]!,
      'hls_certificate': instance.hlsCertificateUrl,
    };

const _$DrmLicenseTypeEnumMap = {
  DrmLicenseType.fairplay: 'fairplay',
  DrmLicenseType.widevine: 'widevine',
  DrmLicenseType.playready: 'playready',
};
