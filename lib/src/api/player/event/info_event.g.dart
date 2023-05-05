// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoEvent _$InfoEventFromJson(Map<String, dynamic> json) => InfoEvent(
      message: json['message'] as String?,
      timestamp: json['timestamp'] as int?,
    );

Map<String, dynamic> _$InfoEventToJson(InfoEvent instance) => <String, dynamic>{
      'timestamp': instance.timestamp,
      'message': instance.message,
    };
