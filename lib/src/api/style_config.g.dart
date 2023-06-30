// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'style_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StyleConfig _$StyleConfigFromJson(Map<String, dynamic> json) => StyleConfig(
      isUiEnabled: json['isUiEnabled'] as bool? ?? true,
      isHideFirstFrame: json['isHideFirstFrame'] as bool? ?? false,
      playerUiCss: json['playerUiCss'] as String?,
      playerUiJs: json['playerUiJs'] as String?,
      supplementalPlayerUiCss: json['supplementalPlayerUiCss'] as String?,
      scalingMode:
          $enumDecodeNullable(_$ScalingModeEnumMap, json['scalingMode']) ??
              ScalingMode.fit,
    );

Map<String, dynamic> _$StyleConfigToJson(StyleConfig instance) =>
    <String, dynamic>{
      'isUiEnabled': instance.isUiEnabled,
      'playerUiCss': instance.playerUiCss,
      'playerUiJs': instance.playerUiJs,
      'supplementalPlayerUiCss': instance.supplementalPlayerUiCss,
      'isHideFirstFrame': instance.isHideFirstFrame,
      'scalingMode': _$ScalingModeEnumMap[instance.scalingMode]!,
    };

const _$ScalingModeEnumMap = {
  ScalingMode.fit: 'Fit',
  ScalingMode.stretch: 'Hls',
  ScalingMode.zoom: 'Zoom',
};
