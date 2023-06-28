import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source_warning_event.g.dart';

/// Emitted when a source warning occurred.
@JsonSerializable(explicitToJson: true)
class SourceWarningEvent extends WarningEvent with EquatableMixin {
  const SourceWarningEvent({
    required super.timestamp,
    required super.code,
    super.message,
  });

  factory SourceWarningEvent.fromJson(Map<String, dynamic> json) {
    return _$SourceWarningEventFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$SourceWarningEventToJson(this);

  @override
  List<Object?> get props => [code, message, timestamp];
}
