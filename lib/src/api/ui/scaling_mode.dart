import 'package:json_annotation/json_annotation.dart';

/// Specifies how the video content is scaled or stretched.
enum ScalingMode {
  @JsonValue('Fit')
  fit,
  @JsonValue('Stretch')
  stretch,
  @JsonValue('Zoom')
  zoom,
}
