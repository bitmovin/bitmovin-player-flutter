// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtitle_changed_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubtitleChangedEvent _$SubtitleChangedEventFromJson(
        Map<String, dynamic> json) =>
    SubtitleChangedEvent(
      timestamp: json['timestamp'] as int?,
      oldSubtitleTrack: json['oldSubtitleTrack'] == null
          ? null
          : SubtitleTrack.fromJson(
              json['oldSubtitleTrack'] as Map<String, dynamic>),
      newSubtitleTrack: json['newSubtitleTrack'] == null
          ? null
          : SubtitleTrack.fromJson(
              json['newSubtitleTrack'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubtitleChangedEventToJson(
        SubtitleChangedEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'oldSubtitleTrack': instance.oldSubtitleTrack?.toJson(),
      'newSubtitleTrack': instance.newSubtitleTrack?.toJson(),
    };
