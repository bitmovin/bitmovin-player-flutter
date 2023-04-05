import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'media_track_role.g.dart';

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

  @JsonKey(name: 'schemeIdUri', disallowNullValue: true)
  final String schemeIdUri;

  @JsonKey(name: 'value', defaultValue: null)
  final String? value;

  @JsonKey(name: 'id', defaultValue: null)
  final String? id;

  Map<String, dynamic> toJson() => _$MediaTrackRoleToJson(this);

  @override
  List<Object?> get props => [
        id,
        schemeIdUri,
        value,
      ];
}
