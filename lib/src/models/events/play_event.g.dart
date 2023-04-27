// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayEvent _$PlayEventFromJson(Map<String, dynamic> json) => PlayEvent(
      time: (json['time'] as num).toDouble(),
      timestamp: json['timestamp'] as int,
    );

Map<String, dynamic> _$PlayEventToJson(PlayEvent instance) => <String, dynamic>{
      'timestamp': instance.timestamp,
      'time': instance.time,
    };
