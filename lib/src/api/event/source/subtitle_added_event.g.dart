// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtitle_added_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubtitleAddedEvent _$SubtitleAddedEventFromJson(Map<String, dynamic> json) =>
    SubtitleAddedEvent(
      subtitleTrack:
          SubtitleTrack.fromJson(json['subtitleTrack'] as Map<String, dynamic>),
      timestamp: (json['timestamp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SubtitleAddedEventToJson(SubtitleAddedEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'subtitleTrack': instance.subtitleTrack.toJson(),
    };
