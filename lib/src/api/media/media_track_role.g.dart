// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_track_role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaTrackRole _$MediaTrackRoleFromJson(Map<String, dynamic> json) =>
    MediaTrackRole(
      schemeIdUri: json['schemeIdUri'] as String,
      id: json['id'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$MediaTrackRoleToJson(MediaTrackRole instance) =>
    <String, dynamic>{
      'schemeIdUri': instance.schemeIdUri,
      'value': instance.value,
      'id': instance.id,
    };
