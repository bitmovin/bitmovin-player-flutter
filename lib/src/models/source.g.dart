// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Source _$SourceFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['sourceConfig'],
  );
  return Source(
    SourceConfig.fromJson(json['sourceConfig'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SourceToJson(Source instance) => <String, dynamic>{
      'sourceConfig': instance.sourceConfig.toJson(),
    };
