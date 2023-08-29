// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'default_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DefaultMetadata _$DefaultMetadataFromJson(Map<String, dynamic> json) =>
    DefaultMetadata(
      cdnProvider: json['cdnProvider'] as String?,
      customUserId: json['customUserId'] as String?,
      customData: json['customData'] == null
          ? const CustomData()
          : CustomData.fromJson(json['customData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DefaultMetadataToJson(DefaultMetadata instance) =>
    <String, dynamic>{
      'cdnProvider': instance.cdnProvider,
      'customUserId': instance.customUserId,
      'customData': instance.customData.toJson(),
    };
