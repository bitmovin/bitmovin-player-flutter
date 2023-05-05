import 'package:bitmovin_sdk/src/api/media/subtitle/subtitle_track.dart';
import 'package:bitmovin_sdk/src/api/media/thumbnail/thumbnail_track.dart';
import 'package:bitmovin_sdk/src/api/source/source_options.dart';
import 'package:bitmovin_sdk/src/api/source/source_type.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source_config.g.dart';

/// Configures a [Source] that can be loaded into a [Player].
@JsonSerializable(explicitToJson: true)
class SourceConfig extends Equatable {
  const SourceConfig({
    required this.url,
    required this.type,
    this.title,
    this.description,
    // this.drmConfig,
    this.audioCodecPriority,
    this.isPosterPersistent,
    // this.labelConfig,
    this.posterSource,
    this.subtitleTracks,
    this.thumbnailTrack,
    this.videoCodecPriority,
    this.options = const SourceOptions(),
  });

  /// Creates a [SourceConfig] from the given [url] and [type]
  factory SourceConfig.createFromUrl(String url, SourceType type) {
    return SourceConfig(url: url, type: type);
  }

  /// Creates a [SourceConfig] from [json]
  factory SourceConfig.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('type')) {
      json['type'] = (json['type'] as String).toLowerCase();
    }
    return _$SourceConfigFromJson(json);
  }

  /// The URL pointing to the media stream with the specified [SourceType].
  @JsonKey(name: 'url', disallowNullValue: true)
  final String url;

  /// The [SourceType] of the [Source].
  @JsonKey(name: 'type')
  final SourceType type;

  /// The title of the [Source].
  @JsonKey(name: 'title', defaultValue: '')
  final String? title;

  /// The descriptions of the [Source].
  @JsonKey(name: 'description', defaultValue: null)
  final String? description;

  /// The URL pointing to the poster image.
  @JsonKey(name: 'posterSource', defaultValue: null)
  final String? posterSource;

  /// Whether the poster is persistent.
  @JsonKey(name: 'isPosterPersistent', defaultValue: false)
  final bool? isPosterPersistent;

  /// A list of additional [SubtitleTrack] available for the [Source].
  @JsonKey(name: 'subtitleTracks', defaultValue: [])
  final List<SubtitleTrack>? subtitleTracks;

  /// The current [ThumbnailTrack] or null.
  @JsonKey(name: 'thumbnailTrack', defaultValue: null)
  final ThumbnailTrack? thumbnailTrack;

  // @JsonKey(name: 'drmConfig', defaultValue: null)
  // final DrmConfig? drmConfig;

  // @JsonKey(name: 'labelConfig', defaultValue:  null)
  // final LabelConfig? labelConfig;

  // final VrConfig? vrConfig:

  /// The video codec priority for the [Source].
  /// First index has the highest priority.
  @JsonKey(name: 'videoCodecPriority', defaultValue: [])
  final List<String>? videoCodecPriority;

  /// The audio codec priority for the [Source].
  /// First index has the highest priority.
  @JsonKey(name: 'audioCodecPriority', defaultValue: [])
  final List<String>? audioCodecPriority;

  /// The additional [SourceOptions] for the [Source].
  @JsonKey(name: 'sourceOptions', defaultValue: null)
  final SourceOptions? options;

  /// Converts this [SourceConfig] into JSON friendly Map<String, dynamic>
  Map<String, dynamic> toJson() => _$SourceConfigToJson(this);

  @override
  List<Object?> get props => [
        url,
        type,
        title,
        description,
        posterSource,
        isPosterPersistent,
        subtitleTracks,
        thumbnailTrack,
        // drmConfig,
        videoCodecPriority,
        audioCodecPriority,
      ];
}
