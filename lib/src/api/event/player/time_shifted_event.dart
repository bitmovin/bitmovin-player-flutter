import 'package:bitmovin_player/src/api/event/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time_shifted_event.g.dart';

/// Called when time shifting has been finished and data is available to
/// continue playback. Only applies to live streams.
@JsonSerializable(explicitToJson: true)
class TimeShiftedEvent extends Event with EquatableMixin {
  const TimeShiftedEvent({
    required super.timestamp,
  });

  factory TimeShiftedEvent.fromJson(Map<String, dynamic> json) {
    return _$TimeShiftedEventFromJson(json);
  }

  @override
  List<Object?> get props => [timestamp];

  @override
  Map<String, dynamic> toJson() => _$TimeShiftedEventToJson(this);
}
