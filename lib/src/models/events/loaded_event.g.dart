// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loaded_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoadedEvent _$LoadedEventFromJson(Map<String, dynamic> json) => LoadedEvent(
      source: Source.fromJson(json['source'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as int,
    );

Map<String, dynamic> _$LoadedEventToJson(LoadedEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'source': instance.source.toJson(),
    };
