import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source_error_event.g.dart';

/// Emitted when a source error occurred.
@JsonSerializable(explicitToJson: true)
class SourceErrorEvent extends ErrorEvent with EquatableMixin {
  const SourceErrorEvent({
    required super.timestamp,
    required super.code,
    super.message,
  });

  factory SourceErrorEvent.fromJson(Map<String, dynamic> json) {
    return _$SourceErrorEventFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$SourceErrorEventToJson(this);
}
