import 'package:bitmovin_player/src/api/media/media_track_role.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subtitle_track.g.dart';

@JsonSerializable(explicitToJson: true)
class SubtitleTrack extends Equatable {
  const SubtitleTrack({
    this.url,
    this.mimeType,
    this.label,
    this.id,
    this.isDefault = false,
    this.isForced = false,
    this.language,
    this.roles = const [],
  });

  factory SubtitleTrack.fromJson(Map<String, dynamic> json) {
    return _$SubtitleTrackFromJson(json);
  }

  @JsonKey(name: 'url')
  final String? url;

  @JsonKey(name: 'mimeType')
  final String? mimeType;

  @JsonKey(name: 'label')
  final String? label;

  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'isDefault')
  final bool? isDefault;

  @JsonKey(name: 'language')
  final String? language;

  @JsonKey(name: 'isForced')
  final bool? isForced;

  @JsonKey(name: 'roles')
  final List<MediaTrackRole>? roles;

  Map<String, dynamic> toJson() => _$SubtitleTrackToJson(this);

  @override
  List<Object?> get props => [
        id,
        mimeType,
        label,
        url,
        isDefault,
        language,
        isForced,
        roles,
      ];
}
