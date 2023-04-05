import 'package:json_annotation/json_annotation.dart';

enum TimelineReferencePoint {
  @JsonValue('Start')
  start,
  @JsonValue('End')
  end,
}

extension TimelineReferencePointExtension on TimelineReferencePoint {
  static const names = {
    TimelineReferencePoint.start: 'Start',
    TimelineReferencePoint.end: 'End',
  };

  String? get name => names[this];
}
