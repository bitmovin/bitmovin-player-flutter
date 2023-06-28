import 'package:json_annotation/json_annotation.dart';

/// Reference points on a timeline to allow definition of relative offsets.
enum TimelineReferencePoint {
  /// Relative offset will be calculated from the beginning of the stream or
  /// DVR window.
  @JsonValue('Start')
  start,

  /// Relative offset will be calculated from the end of the stream or the live
  /// edge in case of a live stream with DVR window.
  @JsonValue('End')
  end,
}

/// @nodoc
extension TimelineReferencePointExtension on TimelineReferencePoint {
  static const names = {
    TimelineReferencePoint.start: 'Start',
    TimelineReferencePoint.end: 'End',
  };

  String? get name => names[this];
}
