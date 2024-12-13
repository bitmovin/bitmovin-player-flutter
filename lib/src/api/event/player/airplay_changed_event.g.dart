// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airplay_changed_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirPlayChangedEvent _$AirPlayChangedEventFromJson(Map<String, dynamic> json) =>
    AirPlayChangedEvent(
      timestamp: (json['timestamp'] as num?)?.toInt(),
      isAirPlayActive: json['isAirPlayActive'] as bool,
      time: (json['time'] as num).toDouble(),
    );

Map<String, dynamic> _$AirPlayChangedEventToJson(
        AirPlayChangedEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'isAirPlayActive': instance.isAirPlayActive,
      'time': instance.time,
    };
