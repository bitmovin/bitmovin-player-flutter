import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'custom_cast_message.g.dart';

/// Arguments to send a message to the cast receiver.
@JsonSerializable(explicitToJson: true)
class CustomCastMessage extends Equatable {
  const CustomCastMessage({
    required this.message,
    this.messageNamespace,
  });

  factory CustomCastMessage.fromJson(Map<String, dynamic> json) {
    return _$CustomCastMessageFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CustomCastMessageToJson(this);

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
