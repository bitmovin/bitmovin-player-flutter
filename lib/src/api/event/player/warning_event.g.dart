// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warning_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarningEvent _$WarningEventFromJson(Map<String, dynamic> json) => WarningEvent(
      timestamp: (json['timestamp'] as num?)?.toInt(),
      code: (json['code'] as num?)?.toInt() ?? 0,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$WarningEventToJson(WarningEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'code': instance.code,
      'message': instance.message,
    };
