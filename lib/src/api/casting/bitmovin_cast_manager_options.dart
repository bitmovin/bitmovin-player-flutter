import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bitmovin_cast_manager_options.g.dart';

/// The options to be used for initializing [BitmovinCastManager]
@JsonSerializable(explicitToJson: true)
class BitmovinCastManagerOptions extends Equatable {
  const BitmovinCastManagerOptions({this.applicationId, this.messageNamespace});

  factory BitmovinCastManagerOptions.fromJson(Map<String, dynamic> json) {
    return _$BitmovinCastManagerOptionsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BitmovinCastManagerOptionsToJson(this);

  /// ID of receiver application.
  /// Using `null` value will result in using the default application ID.
  final String? applicationId;

  /// A custom message namespace to be used for communication between sender and
  /// receiver.
  /// Using `null` value will result in using the default message namespace.
  final String? messageNamespace;

  @override
  List<Object?> get props => [
        applicationId,
        messageNamespace,
      ];
}
