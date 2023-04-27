// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'load_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoadEvent _$LoadEventFromJson(Map<String, dynamic> json) => LoadEvent(
      source: Source.fromJson(json['source'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as int,
    );

Map<String, dynamic> _$LoadEventToJson(LoadEvent instance) => <String, dynamic>{
      'timestamp': instance.timestamp,
      'source': instance.source.toJson(),
    };
