import 'package:bitmovin_player/src/api/event/event.dart';
import 'package:bitmovin_player/src/api/media/subtitle/subtitle_track.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subtitle_added_event.g.dart';

/// Emitted when a new [SubtitleTrack] is added.
@JsonSerializable(explicitToJson: true)
class SubtitleAddedEvent extends Event with EquatableMixin {
  const SubtitleAddedEvent({
    required this.subtitleTrack,
    required super.timestamp,
  });

  factory SubtitleAddedEvent.fromJson(Map<String, dynamic> json) {
    return _$SubtitleAddedEventFromJson(json);
  }

  /// The [SubtitleTrack] that was added.
  final SubtitleTrack subtitleTrack;

  @override
  List<Object?> get props => [subtitleTrack, timestamp];

  @override
  Map<String, dynamic> toJson() => _$SubtitleAddedEventToJson(this);
}
