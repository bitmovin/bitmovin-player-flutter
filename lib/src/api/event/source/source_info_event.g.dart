// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_info_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceInfoEvent _$SourceInfoEventFromJson(Map<String, dynamic> json) =>
    SourceInfoEvent(
      timestamp: json['timestamp'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SourceInfoEventToJson(SourceInfoEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'message': instance.message,
    };
