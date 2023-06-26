import 'package:bitmovin_player/src/api/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paused_event.g.dart';

@JsonSerializable(explicitToJson: true)
class PausedEvent extends Event with EquatableMixin {
  const PausedEvent({
    required this.time,
    required super.timestamp,
  });

  factory PausedEvent.fromJson(Map<String, dynamic> json) {
    return _$PausedEventFromJson(json);
  }

  @JsonKey(name: 'time')
  final double time;

  @override
  List<Object?> get props => [time, timestamp];

  @override
  Map<String, dynamic> toJson() => _$PausedEventToJson(this);
}
