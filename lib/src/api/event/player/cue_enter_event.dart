import 'package:bitmovin_player/src/api/event/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cue_enter_event.g.dart';

/// Emitted when a subtitle cue transitions into the active status.
@JsonSerializable(explicitToJson: true)
class CueEnterEvent extends Event with EquatableMixin {
  const CueEnterEvent({
    required super.timestamp,
    required this.start,
    required this.end,
    this.text,
  });

  factory CueEnterEvent.fromJson(Map<String, dynamic> json) {
    return _$CueEnterEventFromJson(json);
  }

  /// The start time of the cue.
  @JsonKey(name: 'start')
  final double start;

  /// The end time of the cue.
  @JsonKey(name: 'end')
  final double end;

  /// The text of the cue.
  @JsonKey(name: 'text')
  final String? text;

  @override
  Map<String, dynamic> toJson() => _$CueEnterEventToJson(this);

  @override
  List<Object?> get props => [timestamp, start, end, text];
}
