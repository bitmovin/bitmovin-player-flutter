import 'package:bitmovin_sdk/src/models/events/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time_changed_event.g.dart';

@JsonSerializable(explicitToJson: true)
class TimeChangedEvent extends Event with EquatableMixin {
  const TimeChangedEvent({required this.time, required super.timestamp});

  factory TimeChangedEvent.fromJson(Map<String, dynamic> json) {
    return _$TimeChangedEventFromJson(json);
  }
  @JsonKey(name: 'time', defaultValue: 0.0)
  final double time;

  @override
  List<Object?> get props => [time, timestamp];

  @override
  Map<String, dynamic> toJson() => _$TimeChangedEventToJson(this);
}
