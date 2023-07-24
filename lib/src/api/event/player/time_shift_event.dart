import 'package:bitmovin_player/src/api/event/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time_shift_event.g.dart';

/// Called when the player is about to time-shift to a new position.
/// Only applies to live streams.
@JsonSerializable(explicitToJson: true)
class TimeShiftEvent extends Event with EquatableMixin {
  const TimeShiftEvent({
    required this.position,
    required this.target,
    required super.timestamp,
  });

  factory TimeShiftEvent.fromJson(Map<String, dynamic> json) {
    return _$TimeShiftEventFromJson(json);
  }

  /// The position from which we start the time shift (`currentTime` before the
  /// time shift).
  @JsonKey(name: 'position')
  final double position;

  /// The position to which we want to jump for the time shift (`currentTime`
  /// after time shift has completed).
  @JsonKey(name: 'target')
  final double target;

  @override
  List<Object?> get props => [position, target, timestamp];

  @override
  Map<String, dynamic> toJson() => _$TimeShiftEventToJson(this);
}
