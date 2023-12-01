// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picture_in_picture_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PictureInPictureConfig _$PictureInPictureConfigFromJson(
        Map<String, dynamic> json) =>
    PictureInPictureConfig(
      isEnabled: json['isEnabled'] as bool? ?? false,
      shouldEnterOnBackground:
          json['shouldEnterOnBackground'] as bool? ?? false,
    );

Map<String, dynamic> _$PictureInPictureConfigToJson(
        PictureInPictureConfig instance) =>
    <String, dynamic>{
      'isEnabled': instance.isEnabled,
      'shouldEnterOnBackground': instance.shouldEnterOnBackground,
    };
