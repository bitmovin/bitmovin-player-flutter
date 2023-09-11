import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subtitle_track.g.dart';

@JsonSerializable(explicitToJson: true)
class SubtitleTrack extends Equatable {
  const SubtitleTrack({
    required this.id,
    this.url,
    this.format,
    this.label,
    this.isDefault = false,
    this.isForced = false,
    this.language,
    this.roles = const [],
  });

  factory SubtitleTrack.fromJson(Map<String, dynamic> json) {
    return _$SubtitleTrackFromJson(json);
  }

  /// The URL of the [SubtitleTrack].
  @JsonKey(name: 'url')
  final String? url;

  /// Specifies the file format of this [SubtitleTrack].
  @JsonKey(name: 'format')
  final SubtitleFormat? format;

  /// The label for this [SubtitleTrack].
  @JsonKey(name: 'label')
  final String? label;

  /// The unique identifier for this [SubtitleTrack].
  @JsonKey(name: 'id')
  final String id;

  /// Specifies whether the [SubtitleTrack] is a default track.
  /// Default value is `false`.
  @JsonKey(name: 'isDefault')
  final bool isDefault;

  /// The IETF BCP 47 language tag associated with the [SubtitleTrack].
  @JsonKey(name: 'language')
  final String? language;

  /// Tells if a [SubtitleTrack] is forced. If set to `true` it means that the
  /// player should automatically select and switch this subtitle according to
  /// the selected audio language. Forced subtitles do not appear in
  /// [Player.availableSubtitles].
  /// Default value is `false`.
  @JsonKey(name: 'isForced')
  final bool isForced;

  /// Specifies all the DASH roles that are associated with the [SubtitleTrack].
  /// This is only supported on Android.
  @JsonKey(name: 'roles')
  final List<MediaTrackRole> roles;

  Map<String, dynamic> toJson() => _$SubtitleTrackToJson(this);

  @override
  List<Object?> get props => [id];
}
