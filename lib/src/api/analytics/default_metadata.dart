import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'default_metadata.g.dart';

///  [DefaultMetadata] that can be used to enrich the analytics data.
///  [DefaultMetadata] is not bound to a specific source and can be used to set
///  fields for the lifecycle of the collector.
///  If fields are specified in [SourceMetadata] and [DefaultMetadata],
///  [SourceMetadata] takes precedence.
@JsonSerializable(explicitToJson: true)
class DefaultMetadata extends Equatable {
  const DefaultMetadata({
    this.cdnProvider,
    this.customUserId,
    this.customData = const CustomData(),
  });

  factory DefaultMetadata.fromJson(Map<String, dynamic> json) {
    return _$DefaultMetadataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DefaultMetadataToJson(this);

  /// CDN Provider used to serve content.
  /// If field is specified in SourceMetadata and [DefaultMetadata],
  /// [SourceMetadata] takes precedence.
  @JsonKey(name: 'cdnProvider')
  final String? cdnProvider;

  /// Field that can be used to mark a session with the internal User-ID.
  @JsonKey(name: 'customUserId')
  final String? customUserId;

  /// Free-form data that can be used to enrich the analytics data.
  /// If customData is specified in [SourceMetadata] and [DefaultMetadata]
  /// data is merged on a field basis with [SourceMetadata] taking precedence.
  @JsonKey(name: 'customData')
  final CustomData customData;

  @override
  List<Object?> get props => [cdnProvider, customUserId, customData];
}
