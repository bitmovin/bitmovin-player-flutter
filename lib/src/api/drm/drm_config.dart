import 'package:bitmovin_sdk/src/api/drm_license_type.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'drm_config.g.dart';

@JsonSerializable(explicitToJson: true)
class DrmConfig extends Equatable {
  const DrmConfig({
    required this.licenseUrl,
    required this.drmLicenseType,
    this.hlsCertificateUrl,
  });

  factory DrmConfig.fromJson(Map<String, dynamic> json) {
    return _$DrmConfigFromJson(json);
  }
  @JsonKey(name: 'license_url')
  final String licenseUrl;

  @JsonKey(name: 'license_type')
  final DrmLicenseType drmLicenseType;

  @JsonKey(name: 'hls_certificate')
  final String? hlsCertificateUrl;

  Map<String, dynamic> toJson() => _$DrmConfigToJson(this);

  @override
  List<Object?> get props => [licenseUrl, drmLicenseType, hlsCertificateUrl];
}
