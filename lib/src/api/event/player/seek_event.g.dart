// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seek_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeekEvent _$SeekEventFromJson(Map<String, dynamic> json) => SeekEvent(
      from: SeekPosition.fromJson(json['from'] as Map<String, dynamic>),
      to: SeekPosition.fromJson(json['to'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as int?,
    );

Map<String, dynamic> _$SeekEventToJson(SeekEvent instance) => <String, dynamic>{
      'timestamp': instance.timestamp,
      'from': instance.from.toJson(),
      'to': instance.to.toJson(),
    };
