import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subtitle_track.g.dart';

@JsonSerializable(explicitToJson: true)
class SubtitleTrack extends Equatable {
  const SubtitleTrack({
    required this.id,
    required this.label,
    this.url,
    this.format,
    this.isDefault = false,
    this.isForced = false,
    this.language,
    this.roles = const [],
  });

  factory SubtitleTrack.fromJson(Map<String, dynamic> json) {
    return _$SubtitleTrackFromJson(json);
  }

  factory SubtitleTrack.off() => const SubtitleTrack(id: 'off', label: 'off');

  /// The URL of the [SubtitleTrack].
  final String? url;

  /// Specifies the file format of this [SubtitleTrack]. Common values for each
  /// platform are defined in [SubtitleFormats].
  final String? format;

  /// The label for this [SubtitleTrack].
  final String label;

  /// The unique identifier for this [SubtitleTrack].
  final String id;

  /// Specifies whether the [SubtitleTrack] is a default track.
  /// Default value is `false`.
  final bool isDefault;

  /// The IETF BCP 47 language tag associated with the [SubtitleTrack].
  final String? language;

  /// Tells if a [SubtitleTrack] is forced. If set to `true` it means that the
  /// player should automatically select and switch this subtitle according to
  /// the selected audio language. Forced subtitles do not appear in
  /// [Player.availableSubtitles].
  /// Default value is `false`.
  final bool isForced;

  /// Specifies all the DASH roles that are associated with the [SubtitleTrack].
  /// This is only supported on Android.
  final List<MediaTrackRole> roles;

  Map<String, dynamic> toJson() => _$SubtitleTrackToJson(this);

  @override
  List<Object?> get props => [id];
}
