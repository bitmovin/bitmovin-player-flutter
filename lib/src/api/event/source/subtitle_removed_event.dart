import 'package:bitmovin_player/src/api/event/event.dart';
import 'package:bitmovin_player/src/api/media/subtitle/subtitle_track.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subtitle_removed_event.g.dart';

/// Emitted when a [SubtitleTrack] is removed.
@JsonSerializable(explicitToJson: true)
class SubtitleRemovedEvent extends Event with EquatableMixin {
  const SubtitleRemovedEvent({
    required this.subtitleTrack,
    required super.timestamp,
  });

  factory SubtitleRemovedEvent.fromJson(Map<String, dynamic> json) {
    return _$SubtitleRemovedEventFromJson(json);
  }

  /// The [SubtitleTrack] that was removed.
  @JsonKey(name: 'subtitleTrack')
  final SubtitleTrack subtitleTrack;

  @override
  List<Object?> get props => [subtitleTrack, timestamp];

  @override
  Map<String, dynamic> toJson() => _$SubtitleRemovedEventToJson(this);
}
