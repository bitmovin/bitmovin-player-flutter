import 'package:bitmovin_player/src/api/analytics/custom_data.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source_metadata.g.dart';

///  DefaultMetadata that can be used to enrich the analytics data.
///  DefaultMetadata is not bound to a specific source and can be used to set
///  fields for the lifecycle of the collector.
///  If fields are specified in SourceMetadata and DefaultMetadata,
///  SourceMetadata takes precedence.
@JsonSerializable(explicitToJson: true)
class SourceMetadata extends Equatable {
  const SourceMetadata({
    this.title,
    this.videoId,
    this.cdnProvider,
    this.path,
    this.isLive,
    this.customData = const CustomData(),
  });

  factory SourceMetadata.fromJson(Map<String, dynamic> json) {
    return _$SourceMetadataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SourceMetadataToJson(this);

  /// Human readable title of the source.
  @JsonKey(name: 'title')
  final String? title;

  /// ID of the Video
  @JsonKey(name: 'videoId')
  final String? videoId;

  /// CDN Provider used to serve content.
  /// If field is specified in SourceMetadata and DefaultMetadata,
  /// SourceMetadata takes precedence.
  @JsonKey(name: 'cdnProvider')
  final String? cdnProvider;

  /// Breadcrumb within the app. For example, the name of the current activity.
  final String? path;

  /// Mark the stream as live before stream metadata is available.
  /// As soon as metadata is available, information from the player is used.
  @JsonKey(name: 'isLive')
  final bool? isLive;

  /// Free-form data that can be used to enrich the analytics data
  /// If customData is specified in SourceMetadata and DefaultMetadata
  /// data is merged on a field basis with SourceMetadata taking precedence.
  @JsonKey(name: 'customData')
  final CustomData customData;

  @override
  List<Object?> get props => [
        title,
        videoId,
        cdnProvider,
        path,
        isLive,
        customData,
      ];
}
