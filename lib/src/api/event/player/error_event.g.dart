// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorEvent _$ErrorEventFromJson(Map<String, dynamic> json) => ErrorEvent(
      timestamp: (json['timestamp'] as num?)?.toInt(),
      code: (json['code'] as num?)?.toInt() ?? 0,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ErrorEventToJson(ErrorEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'code': instance.code,
      'message': instance.message,
    };
