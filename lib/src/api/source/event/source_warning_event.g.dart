// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_warning_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceWarningEvent _$SourceWarningEventFromJson(Map<String, dynamic> json) =>
    SourceWarningEvent(
      timestamp: json['timestamp'] as int?,
      code: json['code'] as int? ?? 0,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SourceWarningEventToJson(SourceWarningEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'code': instance.code,
      'message': instance.message,
    };
