// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_loaded_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceLoadedEvent _$SourceLoadedEventFromJson(Map<String, dynamic> json) =>
    SourceLoadedEvent(
      source: Source.fromJson(json['source'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as int?,
    );

Map<String, dynamic> _$SourceLoadedEventToJson(SourceLoadedEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'source': instance.source.toJson(),
    };
