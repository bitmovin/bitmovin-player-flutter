import 'package:json_annotation/json_annotation.dart';

enum ScalingMode {
  @JsonValue('Fit')
  fit,
  @JsonValue('Stretch')
  stretch,
  @JsonValue('Zoom')
  zoom,
}
