// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thumbnail_track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThumbnailTrack _$ThumbnailTrackFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['url'],
  );
  return ThumbnailTrack(
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$ThumbnailTrackToJson(ThumbnailTrack instance) =>
    <String, dynamic>{
      'url': instance.url,
    };
