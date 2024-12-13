// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_error_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceErrorEvent _$SourceErrorEventFromJson(Map<String, dynamic> json) =>
    SourceErrorEvent(
      timestamp: (json['timestamp'] as num?)?.toInt(),
      code: (json['code'] as num?)?.toInt() ?? 0,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SourceErrorEventToJson(SourceErrorEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'code': instance.code,
      'message': instance.message,
    };
