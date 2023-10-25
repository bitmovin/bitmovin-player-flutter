// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CastPayload _$CastPayloadFromJson(Map<String, dynamic> json) => CastPayload(
      currentTime: (json['currentTime'] as num).toDouble(),
      deviceName: json['deviceName'] as String?,
    );

Map<String, dynamic> _$CastPayloadToJson(CastPayload instance) =>
    <String, dynamic>{
      'currentTime': instance.currentTime,
      'deviceName': instance.deviceName,
    };
