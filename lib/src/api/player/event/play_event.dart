import 'package:bitmovin_player/src/api/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'play_event.g.dart';

@JsonSerializable(explicitToJson: true)
class PlayEvent extends Event with EquatableMixin {
  const PlayEvent({
    required this.time,
    required super.timestamp,
  });

  factory PlayEvent.fromJson(Map<String, dynamic> json) {
    return _$PlayEventFromJson(json);
  }

  @JsonKey(name: 'time')
  final double time;

  @override
  List<Object?> get props => [time, timestamp];

  @override
  Map<String, dynamic> toJson() => _$PlayEventToJson(this);
}
