// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'casting_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BitmovinCastManagerSendMessage _$BitmovinCastManagerSendMessageFromJson(
        Map<String, dynamic> json) =>
    BitmovinCastManagerSendMessage(
      message: json['message'] as String,
      messageNamespace: json['messageNamespace'] as String?,
    );

Map<String, dynamic> _$BitmovinCastManagerSendMessageToJson(
        BitmovinCastManagerSendMessage instance) =>
    <String, dynamic>{
      'message': instance.message,
      'messageNamespace': instance.messageNamespace,
    };
