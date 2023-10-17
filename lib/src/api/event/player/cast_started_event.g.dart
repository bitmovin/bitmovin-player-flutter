// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast_started_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CastStartedEvent _$CastStartedEventFromJson(Map<String, dynamic> json) =>
    CastStartedEvent(
      deviceName: json['deviceName'] as String?,
      timestamp: json['timestamp'] as int?,
    );

Map<String, dynamic> _$CastStartedEventToJson(CastStartedEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'deviceName': instance.deviceName,
    };
