// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warning_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarningEvent _$WarningEventFromJson(Map<String, dynamic> json) => WarningEvent(
      code: json['code'] as num?,
      message: json['message'] as String?,
      timestamp: json['timestamp'] as int?,
    );

Map<String, dynamic> _$WarningEventToJson(WarningEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'code': instance.code,
      'message': instance.message,
    };
