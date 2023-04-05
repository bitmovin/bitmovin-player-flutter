import 'package:json_annotation/json_annotation.dart';

enum SourceType {
  @JsonValue('Dash')
  dash,
  @JsonValue('Hls')
  hls,
  @JsonValue('Smooth')
  smooth,
  @JsonValue('Progressive')
  progressive,
}

extension SourceTypeExtension on SourceType {
  static const names = {
    SourceType.dash: 'dash',
    SourceType.hls: 'hls',
    SourceType.smooth: 'smooth',
    SourceType.progressive: 'progressive',
  };

  String? get name => names[this];
}
