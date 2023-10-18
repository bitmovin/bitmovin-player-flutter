// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast_started_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CastStartedEvent _$CastStartedEventFromJson(Map<String, dynamic> json) =>
    CastStartedEvent(
      timestamp: json['timestamp'] as int?,
      deviceName: json['deviceName'] as String?,
    );

Map<String, dynamic> _$CastStartedEventToJson(CastStartedEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'deviceName': instance.deviceName,
    };
