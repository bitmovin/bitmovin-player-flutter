// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceOptions _$SourceOptionsFromJson(Map<String, dynamic> json) =>
    SourceOptions(
      startOffset: (json['startOffset'] as num?)?.toDouble(),
      startOffsetTimelineReference: $enumDecodeNullable(
          _$TimelineReferencePointEnumMap,
          json['startOffsetTimelineReference']),
    );

Map<String, dynamic> _$SourceOptionsToJson(SourceOptions instance) =>
    <String, dynamic>{
      'startOffset': instance.startOffset,
      'startOffsetTimelineReference': _$TimelineReferencePointEnumMap[
          instance.startOffsetTimelineReference],
    };

const _$TimelineReferencePointEnumMap = {
  TimelineReferencePoint.start: 'Start',
  TimelineReferencePoint.end: 'End',
};
