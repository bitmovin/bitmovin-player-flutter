import 'package:bitmovin_sdk/src/enums/source_type.dart';
import 'package:bitmovin_sdk/src/models/source_options.dart';
import 'package:bitmovin_sdk/src/models/subtitle_track.dart';
import 'package:bitmovin_sdk/src/models/thumbnail_track.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source_config.g.dart';

@JsonSerializable(explicitToJson: true)
class SourceConfig extends Equatable {
  const SourceConfig({
    required this.url,
    required this.type,
    this.title,
    this.description,
    // this.drmConfig,
    this.audioCodecPriority = const [],
    this.isPosterPersistent = false,
    // this.labelConfig,
    this.posterSource = '',
    this.subtitleTracks = const [],
    this.thumbnailTrack,
    this.videoCodecPriority = const [],
    this.options = const SourceOptions(),
  });

  factory SourceConfig.fromJson(Map<String, dynamic> json) {
    return _$SourceConfigFromJson(json);
  }

  @JsonKey(name: 'url', disallowNullValue: true)
  final String url;

  @JsonKey(name: 'type')
  final SourceType type;

  @JsonKey(name: 'title', defaultValue: '')
  final String? title;

  @JsonKey(name: 'description', defaultValue: '')
  final String? description;

  @JsonKey(name: 'posterSource', defaultValue: '')
  final String? posterSource;

  @JsonKey(name: 'isPosterPersistent', defaultValue: false)
  final bool isPosterPersistent;

  @JsonKey(name: 'subtitleTracks', defaultValue: [])
  final List<SubtitleTrack> subtitleTracks;

  @JsonKey(name: 'thumbnailTrack', defaultValue: null)
  final ThumbnailTrack? thumbnailTrack;

  // @JsonKey(name: 'drmConfig', defaultValue: null)
  // final DrmConfig? drmConfig;

  // @JsonKey(name: 'labelConfig', defaultValue:  null)
  // final LabelConfig? labelConfig;

  // final VrConfig? vrConfig:

  @JsonKey(name: 'videoCodecPriority', defaultValue: [])
  final List<String> videoCodecPriority;

  @JsonKey(name: 'audioCodecPriority', defaultValue: [])
  final List<String> audioCodecPriority;

  @JsonKey(name: 'sourceOptions', defaultValue: null)
  final SourceOptions options;

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
