// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_view_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerViewConfig _$PlayerViewConfigFromJson(Map<String, dynamic> json) =>
    PlayerViewConfig(
      pictureInPictureConfig: json['pictureInPictureConfig'] == null
          ? const PictureInPictureConfig()
          : PictureInPictureConfig.fromJson(
              json['pictureInPictureConfig'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlayerViewConfigToJson(PlayerViewConfig instance) =>
    <String, dynamic>{
      'pictureInPictureConfig': instance.pictureInPictureConfig.toJson(),
    };
