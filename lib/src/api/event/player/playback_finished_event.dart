import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'playback_finished_event.g.dart';

/// Emitted when playback of the [Source] has finished.
@JsonSerializable(explicitToJson: true)
class PlaybackFinishedEvent extends Event with EquatableMixin {
  const PlaybackFinishedEvent({super.timestamp});

  factory PlaybackFinishedEvent.fromJson(Map<String, dynamic> json) {
    return _$PlaybackFinishedEventFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$PlaybackFinishedEventToJson(this);

  @override
  List<Object?> get props => [timestamp];
}
