import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bitmovin_cast_manager_send_message.g.dart';

/// Arguments to send a message to the cast receiver.
@JsonSerializable(explicitToJson: true)
class BitmovinCastManagerSendMessage extends Equatable {
  const BitmovinCastManagerSendMessage({
    required this.message,
    this.messageNamespace,
  });

  factory BitmovinCastManagerSendMessage.fromJson(Map<String, dynamic> json) {
    return _$BitmovinCastManagerSendMessageFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BitmovinCastManagerSendMessageToJson(this);

  /// The message to send.
  final String message;
  /// A custom message namespace to be used for communication between sender and
  /// receiver.
  /// Using `null` value will result in using the default message namespace.
  final String? messageNamespace;

  @override
  List<Object?> get props => [
    message,
    messageNamespace,
  ];
}
