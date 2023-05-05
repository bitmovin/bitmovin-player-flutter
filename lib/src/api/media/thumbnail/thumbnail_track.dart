import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thumbnail_track.g.dart';

@JsonSerializable(explicitToJson: true)
class ThumbnailTrack extends Equatable {
  const ThumbnailTrack({
    required this.url,
  });

  factory ThumbnailTrack.fromJson(Map<String, dynamic> json) {
    return _$ThumbnailTrackFromJson(json);
  }

  @JsonKey(name: 'url', disallowNullValue: true)
  final String url;

  Map<String, dynamic> toJson() => _$ThumbnailTrackToJson(this);

  @override
  List<Object?> get props => [url];
}
