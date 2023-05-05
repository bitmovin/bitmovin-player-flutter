import 'package:bitmovin_sdk/src/api/source/source.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seek_position.g.dart';

@JsonSerializable(explicitToJson: true)
class SeekPosition extends Equatable {
  const SeekPosition({
    required this.source,
    required this.time,
  });

  factory SeekPosition.fromJson(Map<String, dynamic> json) {
    return _$SeekPositionFromJson(json);
  }

  @JsonKey(name: 'source')
  final Source source;

  @JsonKey(name: 'time')
  final double time;

  Map<String, dynamic> toJson() => _$SeekPositionToJson(this);

  @override
  List<Object?> get props => [source, time];
}
