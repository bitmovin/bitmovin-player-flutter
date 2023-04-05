import 'package:json_annotation/json_annotation.dart';

enum ScalingMode {
  @JsonValue('Fit')
  fit,
  @JsonValue('Hls')
  stretch,
  @JsonValue('Zoom')
  zoom,
}

extension ScalingModeExtension on ScalingMode {
  static const names = {
    ScalingMode.fit: 'Fit',
    ScalingMode.stretch: 'Stretch',
    ScalingMode.zoom: 'Soom',
  };

  String? get name => names[this];
}
