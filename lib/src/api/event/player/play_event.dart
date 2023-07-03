import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'play_event.g.dart';

/// Emitted when the player receives an intention to play (i.e [Player.play]).
@JsonSerializable(explicitToJson: true)
class PlayEvent extends Event with EquatableMixin {
  const PlayEvent({
    required this.time,
    required super.timestamp,
  });

  factory PlayEvent.fromJson(Map<String, dynamic> json) {
    return _$PlayEventFromJson(json);
  }

  /// The current playback time (in seconds).
  @JsonKey(name: 'time')
  final double time;

  @override
  List<Object?> get props => [time, timestamp];

  @override
  Map<String, dynamic> toJson() => _$PlayEventToJson(this);
}
