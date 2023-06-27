import 'package:bitmovin_player/src/api/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'warning_event.g.dart';

/// Emitted when a warning occurred.
@JsonSerializable(explicitToJson: true)
class WarningEvent extends Event with EquatableMixin {
  const WarningEvent({
    required this.code,
    this.message,
    super.timestamp,
  });

  factory WarningEvent.fromJson(Map<String, dynamic> json) {
    return _$WarningEventFromJson(json);
  }

  /// The warning code used to identify the warning.
  @JsonKey(name: 'code', defaultValue: null)
  final int code;

  /// The warning message to explain the reason for the warning.
  @JsonKey(name: 'message', defaultValue: null)
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
