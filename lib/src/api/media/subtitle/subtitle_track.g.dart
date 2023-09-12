// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtitle_track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubtitleTrack _$SubtitleTrackFromJson(Map<String, dynamic> json) =>
    SubtitleTrack(
      id: json['id'] as String,
      url: json['url'] as String?,
      format: json['format'] as String?,
      label: json['label'] as String?,
      isDefault: json['isDefault'] as bool? ?? false,
      isForced: json['isForced'] as bool? ?? false,
      language: json['language'] as String?,
      roles: (json['roles'] as List<dynamic>?)
              ?.map((e) => MediaTrackRole.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SubtitleTrackToJson(SubtitleTrack instance) =>
    <String, dynamic>{
      'url': instance.url,
      'format': instance.format,
      'label': instance.label,
      'id': instance.id,
      'isDefault': instance.isDefault,
      'language': instance.language,
      'isForced': instance.isForced,
      'roles': instance.roles.map((e) => e.toJson()).toList(),
    };
