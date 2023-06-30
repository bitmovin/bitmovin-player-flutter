import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error_event.g.dart';

/// The common supertype implemented by all different error events that are
/// emitted by the [Player] or [Source].
@JsonSerializable(explicitToJson: true)
class ErrorEvent extends Event with EquatableMixin {
  const ErrorEvent({
    required super.timestamp,
    required this.code,
    this.message,
  });

  factory ErrorEvent.fromJson(Map<String, dynamic> json) {
    return _$ErrorEventFromJson(json);
  }

  /// The error code used to identify the error.
  @JsonKey(name: 'code', defaultValue: null)
  final int code;

  /// The error message to explain the reason for the error.
  @JsonKey(name: 'message', defaultValue: null)
  final String? message;

  @override
  List<Object?> get props => [
        code,
        message,
        timestamp,
      ];

  @override
  Map<String, dynamic> toJson() => _$ErrorEventToJson(this);
}
