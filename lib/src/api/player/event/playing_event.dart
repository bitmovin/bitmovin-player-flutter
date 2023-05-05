import 'package:bitmovin_sdk/src/api/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'playing_event.g.dart';

@JsonSerializable(explicitToJson: true)
class PlayingEvent extends Event with EquatableMixin {
  const PlayingEvent({
    required this.time,
    required super.timestamp,
  });
  factory PlayingEvent.fromJson(Map<String, dynamic> json) {
    return _$PlayingEventFromJson(json);
  }

  @JsonKey(name: 'time')
  final double time;

  @override
  List<Object?> get props => [time, timestamp];

  @override
  Map<String, dynamic> toJson() => _$PlayingEventToJson(this);
}
