import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'warning_event.g.dart';

/// The common supertype implemented by all different warning events that are
/// emitted by the [Player] or [Source].
@JsonSerializable(explicitToJson: true)
class WarningEvent extends Event with EquatableMixin {
  const WarningEvent({
    required super.timestamp,
    required this.code,
    this.message,
  });

  factory WarningEvent.fromJson(Map<String, dynamic> json) {
    return _$WarningEventFromJson(json);
  }

  /// The warning code used to identify the warning.
  @JsonKey(name: 'code', defaultValue: 0)
  final int code;

  /// The warning message to explain the reason for the warning.
  @JsonKey(name: 'message')
  final String? message;

  @override
  List<Object?> get props => [
        code,
        message,
        timestamp,
      ];

  @override
  Map<String, dynamic> toJson() => _$WarningEventToJson(this);
}
