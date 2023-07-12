// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceConfig _$SourceConfigFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['url'],
  );
  return SourceConfig(
    url: json['url'] as String,
    type: $enumDecode(_$SourceTypeEnumMap, json['type']),
    title: json['title'] as String?,
    description: json['description'] as String?,
    audioCodecPriority: (json['audioCodecPriority'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    isPosterPersistent: json['isPosterPersistent'] as bool? ?? false,
    posterSource: json['posterSource'] as String?,
    subtitleTracks: (json['subtitleTracks'] as List<dynamic>?)
            ?.map((e) => SubtitleTrack.fromJson(e as Map<String, dynamic>))
            .toList() ??
        const [],
    thumbnailTrack: json['thumbnailTrack'] == null
        ? null
        : ThumbnailTrack.fromJson(
            json['thumbnailTrack'] as Map<String, dynamic>),
    videoCodecPriority: (json['videoCodecPriority'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    options: json['sourceOptions'] == null
        ? const SourceOptions()
        : SourceOptions.fromJson(json['sourceOptions'] as Map<String, dynamic>),
    drmConfig: json['drmConfig'] == null
        ? null
        : DrmConfig.fromJson(json['drmConfig'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SourceConfigToJson(SourceConfig instance) =>
    <String, dynamic>{
      'url': instance.url,
      'type': _$SourceTypeEnumMap[instance.type]!,
      'title': instance.title,
      'description': instance.description,
      'posterSource': instance.posterSource,
      'isPosterPersistent': instance.isPosterPersistent,
      'subtitleTracks':
          instance.subtitleTracks?.map((e) => e.toJson()).toList(),
      'thumbnailTrack': instance.thumbnailTrack?.toJson(),
      'videoCodecPriority': instance.videoCodecPriority,
      'audioCodecPriority': instance.audioCodecPriority,
      'sourceOptions': instance.options.toJson(),
      'drmConfig': instance.drmConfig?.toJson(),
    };

const _$SourceTypeEnumMap = {
  SourceType.dash: 'dash',
  SourceType.hls: 'hls',
  SourceType.progressive: 'progressive',
};
