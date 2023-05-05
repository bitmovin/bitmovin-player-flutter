import 'package:bitmovin_sdk/src/api/media/media_track_role.dart';
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
    this.isDefault,
    this.isForced,
    this.language,
    this.roles,
  });

  factory SubtitleTrack.fromJson(Map<String, dynamic> json) {
    return _$SubtitleTrackFromJson(json);
  }

  @JsonKey(name: 'url', defaultValue: null)
  final String? url;

  @JsonKey(name: 'mimeType', defaultValue: null)
  final String? mimeType;

  @JsonKey(name: 'label', defaultValue: null)
  final String? label;

  @JsonKey(name: 'id', defaultValue: null)
  final String? id;

  @JsonKey(name: 'isDefault', defaultValue: false)
  final bool? isDefault;

  @JsonKey(name: 'language', defaultValue: null)
  final String? language;

  @JsonKey(name: 'isForced', defaultValue: false)
  final bool? isForced;

  @JsonKey(name: 'roles', defaultValue: [])
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
