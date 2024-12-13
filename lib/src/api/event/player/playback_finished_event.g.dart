// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playback_finished_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaybackFinishedEvent _$PlaybackFinishedEventFromJson(
        Map<String, dynamic> json) =>
    PlaybackFinishedEvent(
      timestamp: (json['timestamp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PlaybackFinishedEventToJson(
        PlaybackFinishedEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
    };
