// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_error_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceErrorEvent _$SourceErrorEventFromJson(Map<String, dynamic> json) =>
    SourceErrorEvent(
      code: json['code'] as int,
      data: json['data'],
      message: json['message'] as String?,
      timestamp: json['timestamp'] as int?,
    );

Map<String, dynamic> _$SourceErrorEventToJson(SourceErrorEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };
