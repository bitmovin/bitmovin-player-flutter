// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seek_position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeekPosition _$SeekPositionFromJson(Map<String, dynamic> json) => SeekPosition(
      source: Source.fromJson(json['source'] as Map<String, dynamic>),
      time: (json['time'] as num).toDouble(),
    );

Map<String, dynamic> _$SeekPositionToJson(SeekPosition instance) =>
    <String, dynamic>{
      'source': instance.source.toJson(),
      'time': instance.time,
    };
