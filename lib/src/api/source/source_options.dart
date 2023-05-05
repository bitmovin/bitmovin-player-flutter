import 'package:bitmovin_sdk/src/api/source/timeline_reference_point.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source_options.g.dart';

@JsonSerializable(explicitToJson: true)
class SourceOptions extends Equatable {
  const SourceOptions({
    this.startOffset,
    this.startOffsetTimelineReference,
  });

  factory SourceOptions.fromJson(Map<String, dynamic> json) {
    return _$SourceOptionsFromJson(json);
  }

  @JsonKey(name: 'startOffset', defaultValue: null)
  final double? startOffset;

  @JsonKey(name: 'startOffsetTimelineReference', defaultValue: null)
  final TimelineReferencePoint? startOffsetTimelineReference;

  Map<String, dynamic> toJson() => _$SourceOptionsToJson(this);

  @override
  List<Object?> get props => [
        startOffset,
        startOffsetTimelineReference,
      ];
}
