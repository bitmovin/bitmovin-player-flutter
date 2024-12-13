// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_added_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceAddedEvent _$SourceAddedEventFromJson(Map<String, dynamic> json) =>
    SourceAddedEvent(
      source: Source.fromJson(json['source'] as Map<String, dynamic>),
      timestamp: (json['timestamp'] as num?)?.toInt(),
      index: (json['index'] as num).toInt(),
    );

Map<String, dynamic> _$SourceAddedEventToJson(SourceAddedEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'source': instance.source.toJson(),
      'index': instance.index,
    };
