// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playback_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaybackConfig _$PlaybackConfigFromJson(Map<String, dynamic> json) =>
    PlaybackConfig(
      isAutoplayEnabled: json['isAutoplayEnabled'] as bool? ?? false,
      isMuted: json['isMuted'] as bool? ?? false,
      isTimeShiftEnabled: json['isTimeShiftEnabled'] as bool? ?? true,
      videoCodecPriority: (json['videoCodecPriority'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      audioCodecPriority: (json['audioCodecPriority'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isTunneledPlaybackEnabled:
          json['isTunneledPlaybackEnabled'] as bool? ?? false,
      seekMode: $enumDecodeNullable(_$SeekModeEnumMap, json['seekMode']) ??
          SeekMode.exact,
      audioFilter:
          $enumDecodeNullable(_$MediaFilterEnumMap, json['audioFilter']) ??
              MediaFilter.loose,
      videoFilter:
          $enumDecodeNullable(_$MediaFilterEnumMap, json['videoFilter']) ??
              MediaFilter.loose,
    );

Map<String, dynamic> _$PlaybackConfigToJson(PlaybackConfig instance) =>
    <String, dynamic>{
      'isAutoplayEnabled': instance.isAutoplayEnabled,
      'isMuted': instance.isMuted,
      'isTimeShiftEnabled': instance.isTimeShiftEnabled,
      'videoCodecPriority': instance.videoCodecPriority,
      'audioCodecPriority': instance.audioCodecPriority,
      'isTunneledPlaybackEnabled': instance.isTunneledPlaybackEnabled,
      'seekMode': _$SeekModeEnumMap[instance.seekMode],
      'audioFilter': _$MediaFilterEnumMap[instance.audioFilter]!,
      'videoFilter': _$MediaFilterEnumMap[instance.videoFilter]!,
    };

const _$SeekModeEnumMap = {
  SeekMode.exact: 'Exact',
  SeekMode.closesSync: 'ClosestSync',
  SeekMode.previousSync: 'PreviousSync',
  SeekMode.nextSync: 'NextSync',
};

const _$MediaFilterEnumMap = {
  MediaFilter.none: 'None',
  MediaFilter.loose: 'Loose',
  MediaFilter.strict: 'Strict',
};
