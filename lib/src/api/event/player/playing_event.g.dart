// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playing_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayingEvent _$PlayingEventFromJson(Map<String, dynamic> json) => PlayingEvent(
      time: (json['time'] as num).toDouble(),
      timestamp: (json['timestamp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PlayingEventToJson(PlayingEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'time': instance.time,
    };
