// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_removed_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceRemovedEvent _$SourceRemovedEventFromJson(Map<String, dynamic> json) =>
    SourceRemovedEvent(
      source: Source.fromJson(json['source'] as Map<String, dynamic>),
      timestamp: (json['timestamp'] as num?)?.toInt(),
      index: (json['index'] as num).toInt(),
    );

Map<String, dynamic> _$SourceRemovedEventToJson(SourceRemovedEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'source': instance.source.toJson(),
      'index': instance.index,
    };
