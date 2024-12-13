// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paused_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PausedEvent _$PausedEventFromJson(Map<String, dynamic> json) => PausedEvent(
      time: (json['time'] as num).toDouble(),
      timestamp: (json['timestamp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PausedEventToJson(PausedEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'time': instance.time,
    };
