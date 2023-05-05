// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtitle_track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubtitleTrack _$SubtitleTrackFromJson(Map<String, dynamic> json) =>
    SubtitleTrack(
      url: json['url'] as String?,
      mimeType: json['mimeType'] as String?,
      label: json['label'] as String?,
      id: json['id'] as String?,
      isDefault: json['isDefault'] as bool? ?? false,
      isForced: json['isForced'] as bool? ?? false,
      language: json['language'] as String?,
      roles: (json['roles'] as List<dynamic>?)
              ?.map((e) => MediaTrackRole.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$SubtitleTrackToJson(SubtitleTrack instance) =>
    <String, dynamic>{
      'url': instance.url,
      'mimeType': instance.mimeType,
      'label': instance.label,
      'id': instance.id,
      'isDefault': instance.isDefault,
      'language': instance.language,
      'isForced': instance.isForced,
      'roles': instance.roles?.map((e) => e.toJson()).toList(),
    };
