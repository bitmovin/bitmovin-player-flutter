import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'media_track_role.g.dart';

/// Describes the DASH Role of a [SubtitleTrack] as specified in
/// ISO/IEC 23009-1:2019, section 5.8.4.2.
@JsonSerializable(explicitToJson: true)
class MediaTrackRole extends Equatable {
  const MediaTrackRole({
    required this.schemeIdUri,
    this.id,
    this.value,
  });

  factory MediaTrackRole.fromJson(Map<String, dynamic> json) {
    return _$MediaTrackRoleFromJson(json);
  }

  /// Specifies a URI to identify the Role scheme as described in the MPD.
  @JsonKey(name: 'schemeIdUri', disallowNullValue: true)
  final String schemeIdUri;

  /// Specifies the value for the Role as described in the MPD.
  @JsonKey(name: 'value')
  final String? value;

  /// Specifies an identifier for the Role as described in the MPD.
  @JsonKey(name: 'id')
  final String? id;

  Map<String, dynamic> toJson() => _$MediaTrackRoleToJson(this);

  @override
  List<Object?> get props => [
        id,
        schemeIdUri,
        value,
      ];
}
