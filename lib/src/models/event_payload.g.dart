// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventPayload _$EventPayloadFromJson(Map<String, dynamic> json) => EventPayload(
      eventName: json['event'] as String,
      data: json['data'],
    );

Map<String, dynamic> _$EventPayloadToJson(EventPayload instance) =>
    <String, dynamic>{
      'event': instance.eventName,
      'data': instance.data,
    };
