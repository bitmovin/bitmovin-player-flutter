import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/api/analytics/source_metadata.dart';
import 'package:bitmovin_player/src/api/media/subtitle/subtitle_track.dart';
import 'package:bitmovin_player/src/api/media/thumbnail/thumbnail_track.dart';
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
    this.audioCodecPriority,
    this.isPosterPersistent = false,
    this.posterSource,
    this.subtitleTracks = const [],
    this.thumbnailTrack,
    this.videoCodecPriority,
    this.options = const SourceOptions(),
    this.drmConfig,
    this.sourceMetadata,
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
  @JsonKey(name: 'title')
  final String? title;

  /// The descriptions of the [Source].
  @JsonKey(name: 'description')
  final String? description;

  /// The URL pointing to the poster image.
  @JsonKey(name: 'posterSource')
  final String? posterSource;

  /// Whether the poster is persistent.
  /// Default value is `false`
  @JsonKey(name: 'isPosterPersistent')
  final bool isPosterPersistent;

  /// A list of additional [SubtitleTrack] available for the [Source].
  @JsonKey(name: 'subtitleTracks')
  final List<SubtitleTrack>? subtitleTracks;

  /// The current [ThumbnailTrack] or null.
  @JsonKey(name: 'thumbnailTrack')
  final ThumbnailTrack? thumbnailTrack;

  /// The video codec priority for the [Source] where the index has the highest
  /// priority. Default value is `null`. In this case the player will use the
  /// default that is provided by the platform.
  ///
  /// This is only supported on Android.
  @JsonKey(name: 'videoCodecPriority')
  final List<String>? videoCodecPriority;

  /// The audio codec priority for the [Source] where the index has the highest
  /// priority. Default value is `null`. In this case the player will use the
  /// default that is provided by the platform.
  ///
  /// This is only supported on Android.
  @JsonKey(name: 'audioCodecPriority')
  final List<String>? audioCodecPriority;

  /// The additional [SourceOptions] for the [Source].
  @JsonKey(name: 'options')
  final SourceOptions options;

  /// The [DrmConfig] for the [Source].
  @JsonKey(name: 'drmConfig')
  final DrmConfig? drmConfig;

  /// The [SourceMetadata] for the [Source],
  /// to setup custom analytics tracking
  @JsonKey(name: 'sourceMetadata')
  final SourceMetadata? sourceMetadata;

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
        videoCodecPriority,
        audioCodecPriority,
        drmConfig,
        sourceMetadata,
      ];
}
