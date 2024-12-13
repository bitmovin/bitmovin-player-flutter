// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtitle_removed_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubtitleRemovedEvent _$SubtitleRemovedEventFromJson(
        Map<String, dynamic> json) =>
    SubtitleRemovedEvent(
      subtitleTrack:
          SubtitleTrack.fromJson(json['subtitleTrack'] as Map<String, dynamic>),
      timestamp: (json['timestamp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SubtitleRemovedEventToJson(
        SubtitleRemovedEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'subtitleTrack': instance.subtitleTrack.toJson(),
    };
