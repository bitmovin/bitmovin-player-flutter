import 'package:bitmovin_player/src/api/event/event.dart';
import 'package:bitmovin_player/src/api/media/subtitle/subtitle_track.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subtitle_changed_event.g.dart';

/// Emitted when the selected [SubtitleTrack] is changed.
@JsonSerializable(explicitToJson: true)
class SubtitleChangedEvent extends Event with EquatableMixin {
  const SubtitleChangedEvent({
    required super.timestamp,
    this.oldSubtitleTrack,
    this.newSubtitleTrack,
  });

  factory SubtitleChangedEvent.fromJson(Map<String, dynamic> json) {
    return _$SubtitleChangedEventFromJson(json);
  }

  /// The [SubtitleTrack] before the change.
  @JsonKey(name: 'oldSubtitleTrack')
  final SubtitleTrack? oldSubtitleTrack;

  /// The [SubtitleTrack] after the change.
  @JsonKey(name: 'newSubtitleTrack')
  final SubtitleTrack? newSubtitleTrack;

  @override
  List<Object?> get props => [oldSubtitleTrack, newSubtitleTrack, timestamp];

  @override
  Map<String, dynamic> toJson() => _$SubtitleChangedEventToJson(this);
}
