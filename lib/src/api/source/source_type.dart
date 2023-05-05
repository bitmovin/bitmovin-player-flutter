import 'package:json_annotation/json_annotation.dart';

enum SourceType {
  @JsonValue('dash')
  dash,
  @JsonValue('hls')
  hls,
  @JsonValue('progressive')
  progressive,
  @JsonValue('movpkg')
  movpkg,
  @JsonValue('unknown')
  unknown,
  @JsonValue('none')
  none,
}

extension SourceTypeExtension on SourceType {
  static const names = {
    SourceType.dash: 'dash',
    SourceType.hls: 'hls',
    SourceType.progressive: 'progressive',
    SourceType.movpkg: 'movpkg',
    SourceType.none: 'none',
    SourceType.unknown: 'unknown',
  };

  String? get name => names[this];
}
