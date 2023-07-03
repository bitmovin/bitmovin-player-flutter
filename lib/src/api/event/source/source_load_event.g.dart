// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_load_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceLoadEvent _$SourceLoadEventFromJson(Map<String, dynamic> json) =>
    SourceLoadEvent(
      source: Source.fromJson(json['source'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as int?,
    );

Map<String, dynamic> _$SourceLoadEventToJson(SourceLoadEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'source': instance.source.toJson(),
    };
