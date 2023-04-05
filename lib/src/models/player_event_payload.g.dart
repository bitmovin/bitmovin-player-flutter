// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_event_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerEventPayload _$PlayerEventPayloadFromJson(Map<String, dynamic> json) =>
    PlayerEventPayload(
      type: $enumDecodeNullable(_$PlayerEventEnumMap, json['type']),
      currentTime: (json['currentTime'] as num?)?.toDouble(),
      duration: (json['duration'] as num?)?.toDouble(),
      code: json['code'] as String?,
      message: json['message'] as String?,
      data: json['data'],
    );

Map<String, dynamic> _$PlayerEventPayloadToJson(PlayerEventPayload instance) =>
    <String, dynamic>{
      'type': _$PlayerEventEnumMap[instance.type],
      'currentTime': instance.currentTime,
      'duration': instance.duration,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

const _$PlayerEventEnumMap = {
  PlayerEvent.active: 'active',
  PlayerEvent.ready: 'ready',
  PlayerEvent.play: 'play',
  PlayerEvent.pause: 'pause',
  PlayerEvent.stop: 'stop',
  PlayerEvent.timechanged: 'time_changed',
  PlayerEvent.playing: 'playing',
  PlayerEvent.playbackfinished: 'playback_finished',
  PlayerEvent.destroy: 'destroy',
  PlayerEvent.load: 'load',
  PlayerEvent.loaded: 'loaded',
  PlayerEvent.warning: 'warning',
  PlayerEvent.error: 'error',
  PlayerEvent.bufferStarted: 'buffering_started',
  PlayerEvent.bufferingEnded: 'buffering_ended',
  PlayerEvent.sourceError: 'source_error',
  PlayerEvent.networkError: 'network_error',
  PlayerEvent.renderedFirstFrame: 'rendered_first_frame',
  PlayerEvent.seeked: 'seeked',
  PlayerEvent.seek: 'seek',
};
