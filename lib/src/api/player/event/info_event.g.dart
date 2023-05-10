// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoEvent _$InfoEventFromJson(Map<String, dynamic> json) => InfoEvent(
      timestamp: json['timestamp'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$InfoEventToJson(InfoEvent instance) => <String, dynamic>{
      'timestamp': instance.timestamp,
      'message': instance.message,
    };
