// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_info_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceInfoEvent _$SourceInfoEventFromJson(Map<String, dynamic> json) =>
    SourceInfoEvent(
      message: json['message'] as String?,
      timestamp: json['timestamp'] as int?,
    );

Map<String, dynamic> _$SourceInfoEventToJson(SourceInfoEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'message': instance.message,
    };
