import 'package:bitmovin_player/src/api/event/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cue_exit_event.g.dart';

/// Emitted when a subtitle cue transitions into the inactive status.
@JsonSerializable(explicitToJson: true)
class CueExitEvent extends Event with EquatableMixin {
  const CueExitEvent({
    required super.timestamp,
    required this.start,
    required this.end,
    this.text,
  });

  factory CueExitEvent.fromJson(Map<String, dynamic> json) {
    return _$CueExitEventFromJson(json);
  }

  /// The start time of the cue.
  final double start;

  /// The end time of the cue.
  final double end;

  /// The text of the cue.
  final String? text;

  @override
  Map<String, dynamic> toJson() => _$CueExitEventToJson(this);

  @override
  List<Object?> get props => [timestamp, start, end, text];
}
