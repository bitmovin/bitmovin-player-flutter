// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cue_enter_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CueEnterEvent _$CueEnterEventFromJson(Map<String, dynamic> json) =>
    CueEnterEvent(
      timestamp: json['timestamp'] as int?,
      start: (json['start'] as num).toDouble(),
      end: (json['end'] as num).toDouble(),
      text: json['text'] as String?,
    );

Map<String, dynamic> _$CueEnterEventToJson(CueEnterEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'start': instance.start,
      'end': instance.end,
      'text': instance.text,
    };
