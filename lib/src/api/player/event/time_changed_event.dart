import 'package:bitmovin_player/src/api/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time_changed_event.g.dart';

@JsonSerializable(explicitToJson: true)
class TimeChangedEvent extends Event with EquatableMixin {
  const TimeChangedEvent({required this.time, required super.timestamp});

  factory TimeChangedEvent.fromJson(Map<String, dynamic> json) {
    /// The key `currentTime` is only available in iOS.
    if (json.containsKey('currentTime')) {
      /// map `currentTime` to `time`
      json['time'] = json['currentTime'];
    }
    return _$TimeChangedEventFromJson(json);
  }
  @JsonKey(name: 'time', defaultValue: 0.0)
  final double time;

  @override
  List<Object?> get props => [time, timestamp];

  @override
  Map<String, dynamic> toJson() => _$TimeChangedEventToJson(this);
}
