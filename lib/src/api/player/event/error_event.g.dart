// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorEvent _$ErrorEventFromJson(Map<String, dynamic> json) => ErrorEvent(
      timestamp: json['timestamp'] as int?,
      code: json['code'] as int,
      message: json['message'] as String?,
      data: json['data'],
    );

Map<String, dynamic> _$ErrorEventToJson(ErrorEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };
