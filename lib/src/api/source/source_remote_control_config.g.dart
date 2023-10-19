// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_remote_control_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceRemoteControlConfig _$SourceRemoteControlConfigFromJson(
        Map<String, dynamic> json) =>
    SourceRemoteControlConfig(
      castSourceConfig: json['castSourceConfig'] == null
          ? null
          : SourceConfig.fromJson(
              json['castSourceConfig'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SourceRemoteControlConfigToJson(
        SourceRemoteControlConfig instance) =>
    <String, dynamic>{
      'castSourceConfig': instance.castSourceConfig?.toJson(),
    };
