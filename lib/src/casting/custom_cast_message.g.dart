// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_cast_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomCastMessage _$CustomCastMessageFromJson(Map<String, dynamic> json) =>
    CustomCastMessage(
      message: json['message'] as String,
      messageNamespace: json['messageNamespace'] as String?,
    );

Map<String, dynamic> _$CustomCastMessageToJson(CustomCastMessage instance) =>
    <String, dynamic>{
      'message': instance.message,
      'messageNamespace': instance.messageNamespace,
    };
