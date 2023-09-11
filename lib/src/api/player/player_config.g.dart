// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerConfig _$PlayerConfigFromJson(Map<String, dynamic> json) => PlayerConfig(
      key: json['key'] as String?,
      styleConfig: json['styleConfig'] == null
          ? const StyleConfig()
          : StyleConfig.fromJson(json['styleConfig'] as Map<String, dynamic>),
      playbackConfig: json['playbackConfig'] == null
          ? const PlaybackConfig()
          : PlaybackConfig.fromJson(
              json['playbackConfig'] as Map<String, dynamic>),
      licensingConfig: json['licensingConfig'] == null
          ? const LicensingConfig()
          : LicensingConfig.fromJson(
              json['licensingConfig'] as Map<String, dynamic>),
      liveConfig: json['liveConfig'] == null
          ? const LiveConfig()
          : LiveConfig.fromJson(json['liveConfig'] as Map<String, dynamic>),
      analyticsConfig: json['analyticsConfig'] == null
          ? null
          : AnalyticsConfig.fromJson(
              json['analyticsConfig'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlayerConfigToJson(PlayerConfig instance) =>
    <String, dynamic>{
      'key': instance.key,
      'styleConfig': instance.styleConfig?.toJson(),
      'playbackConfig': instance.playbackConfig?.toJson(),
      'licensingConfig': instance.licensingConfig?.toJson(),
      'liveConfig': instance.liveConfig.toJson(),
      'analyticsConfig': instance.analyticsConfig?.toJson(),
    };
