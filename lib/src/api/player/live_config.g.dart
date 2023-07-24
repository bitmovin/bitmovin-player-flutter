// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveConfig _$LiveConfigFromJson(Map<String, dynamic> json) => LiveConfig(
      minTimeShiftBufferDepth:
          (json['minTimeShiftBufferDepth'] as num?)?.toDouble() ?? -40.0,
      liveEdgeOffset: (json['liveEdgeOffset'] as num?)?.toDouble() ?? -1.0,
    );

Map<String, dynamic> _$LiveConfigToJson(LiveConfig instance) =>
    <String, dynamic>{
      'minTimeShiftBufferDepth': instance.minTimeShiftBufferDepth,
      'liveEdgeOffset': instance.liveEdgeOffset,
    };
