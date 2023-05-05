// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_changed_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeChangedEvent _$TimeChangedEventFromJson(Map<String, dynamic> json) =>
    TimeChangedEvent(
      time: (json['time'] as num?)?.toDouble() ?? 0.0,
      timestamp: json['timestamp'] as int?,
    );

Map<String, dynamic> _$TimeChangedEventToJson(TimeChangedEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'time': instance.time,
    };
