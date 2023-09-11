// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceMetadata _$SourceMetadataFromJson(Map<String, dynamic> json) =>
    SourceMetadata(
      title: json['title'] as String?,
      videoId: json['videoId'] as String?,
      cdnProvider: json['cdnProvider'] as String?,
      path: json['path'] as String?,
      isLive: json['isLive'] as bool?,
      customData: json['customData'] == null
          ? const CustomData()
          : CustomData.fromJson(json['customData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SourceMetadataToJson(SourceMetadata instance) =>
    <String, dynamic>{
      'title': instance.title,
      'videoId': instance.videoId,
      'cdnProvider': instance.cdnProvider,
      'path': instance.path,
      'isLive': instance.isLive,
      'customData': instance.customData.toJson(),
    };
