// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_error_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceErrorEvent _$SourceErrorEventFromJson(Map<String, dynamic> json) =>
    SourceErrorEvent(
      timestamp: json['timestamp'] as int?,
      code: json['code'] as int? ?? 0,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SourceErrorEventToJson(SourceErrorEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'code': instance.code,
      'message': instance.message,
    };
