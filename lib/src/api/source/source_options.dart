import 'package:bitmovin_player/src/api/source/timeline_reference_point.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source_options.g.dart';

/// Options to allow configuration of the source.
@JsonSerializable(explicitToJson: true)
class SourceOptions extends Equatable {
  const SourceOptions({
    this.startOffset,
    this.startOffsetTimelineReference,
  });

  factory SourceOptions.fromJson(Map<String, dynamic> json) {
    return _$SourceOptionsFromJson(json);
  }

  /// The position where the stream should be started.
  /// Number can be positive or negative depending on the used
  /// [TimelineReferencePoint]. Invalid numbers will be corrected according to
  /// the stream boundaries.
  ///
  /// For VOD this is applied at the time the stream is loaded, for LIVE when
  /// playback starts. For HLS streams setting a [startOffset] overrides a
  /// potential `EXT-X-START:TIME-OFFSET` value.
  ///
  /// Default value is `null`.
  @JsonKey(name: 'startOffset')
  final double? startOffset;

  /// Sets the Timeline reference point to calculate the [startOffset] from.
  /// If not set, default values will be used.
  ///
  /// Default value for VOD: [TimelineReferencePoint.start]
  /// Default value for live: [TimelineReferencePoint.end]
  @JsonKey(name: 'startOffsetTimelineReference')
  final TimelineReferencePoint? startOffsetTimelineReference;

  Map<String, dynamic> toJson() => _$SourceOptionsToJson(this);

  @override
  List<Object?> get props => [
        startOffset,
        startOffsetTimelineReference,
      ];
}
