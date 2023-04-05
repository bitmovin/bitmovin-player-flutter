import 'package:json_annotation/json_annotation.dart';

enum DrmLicenseType {
  @JsonValue('fairplay')
  fairplay,
  @JsonValue('widevine')
  widevine,
  @JsonValue('playready')
  playready,
}

extension DrmLicenseTypeExtension on DrmLicenseType {
  static const names = {
    DrmLicenseType.fairplay: 'fairplay',
    DrmLicenseType.widevine: 'widevine',
    DrmLicenseType.playready: 'playready',
  };

  String? get name => names[this];
}
