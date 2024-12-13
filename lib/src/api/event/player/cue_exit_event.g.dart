// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cue_exit_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CueExitEvent _$CueExitEventFromJson(Map<String, dynamic> json) => CueExitEvent(
      timestamp: (json['timestamp'] as num?)?.toInt(),
      start: (json['start'] as num).toDouble(),
      end: (json['end'] as num).toDouble(),
      text: json['text'] as String?,
    );

Map<String, dynamic> _$CueExitEventToJson(CueExitEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'start': instance.start,
      'end': instance.end,
      'text': instance.text,
    };
