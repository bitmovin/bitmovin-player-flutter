// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_warning_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceWarningEvent _$SourceWarningEventFromJson(Map<String, dynamic> json) =>
    SourceWarningEvent(
      code: json['code'] as int,
      message: json['message'] as String?,
      timestamp: json['timestamp'] as int?,
    );

Map<String, dynamic> _$SourceWarningEventToJson(SourceWarningEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'code': instance.code,
      'message': instance.message,
    };
