// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Source _$SourceFromJson(Map<String, dynamic> json) => Source(
      sourceConfig:
          SourceConfig.fromJson(json['sourceConfig'] as Map<String, dynamic>),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$SourceToJson(Source instance) => <String, dynamic>{
      'id': instance.id,
      'sourceConfig': instance.sourceConfig.toJson(),
    };
