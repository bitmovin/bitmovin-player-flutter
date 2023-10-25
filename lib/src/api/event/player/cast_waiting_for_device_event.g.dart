// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast_waiting_for_device_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CastWaitingForDeviceEvent _$CastWaitingForDeviceEventFromJson(
        Map<String, dynamic> json) =>
    CastWaitingForDeviceEvent(
      castPayload:
          CastPayload.fromJson(json['castPayload'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as int?,
    );

Map<String, dynamic> _$CastWaitingForDeviceEventToJson(
        CastWaitingForDeviceEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'castPayload': instance.castPayload.toJson(),
    };
