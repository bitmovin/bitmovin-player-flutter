import 'package:bitmovin_sdk/src/enums/media_filter.dart';
import 'package:bitmovin_sdk/src/enums/seek_mode.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'playback_config.g.dart';

@JsonSerializable(explicitToJson: true)
class PlaybackConfig extends Equatable {
  const PlaybackConfig({
    this.isAutoplayEnabled = false,
    this.isMuted = false,
    this.isTimeShiftEnabled = true,
    this.videoCodecPriority = const [
      'av1',
      'hevc',
      'hvc',
      'vp9',
      'avc',
    ],
    this.audioCodecPriority = const [
      'ec-3',
      'mp4a.a6',
      'ac-3',
      'mp4a.a5',
      'mp4a.40'
    ],
    this.isTunneledPlaybackEnabled = false,
    this.seekMode = SeekMode.exact,
    this.audioFilter = MediaFilter.loose,
    this.videoFilter = MediaFilter.loose,
  });

  factory PlaybackConfig.fromJson(Map<String, dynamic> json) {
    return _$PlaybackConfigFromJson(json);
  }

  @JsonKey(name: 'isAutoplayEnabled', defaultValue: false)
  final bool? isAutoplayEnabled;

  @JsonKey(name: 'isMuted', defaultValue: false)
  final bool? isMuted;

  @JsonKey(name: 'isTimeShiftEnabled', defaultValue: true)
  final bool? isTimeShiftEnabled;

  @JsonKey(name: 'videoCodecPriority', defaultValue: [])
  final List<String>? videoCodecPriority;

  @JsonKey(name: 'audioCodecPriority', defaultValue: [])
  final List<String>? audioCodecPriority;

  @JsonKey(name: 'isTunneledPlaybackEnabled', defaultValue: false)
  final bool? isTunneledPlaybackEnabled;

  @JsonKey(name: 'seekMode', defaultValue: SeekMode.exact)
  final SeekMode? seekMode;

  @JsonKey(name: 'audioFilter', defaultValue: MediaFilter.loose)
  final MediaFilter audioFilter;

  @JsonKey(name: 'videoFilter', defaultValue: MediaFilter.loose)
  final MediaFilter videoFilter;

  Map<String, dynamic> toJson() => _$PlaybackConfigToJson(this);

  @override
  List<Object?> get props => [
        isAutoplayEnabled,
        isMuted,
        isTimeShiftEnabled,
        videoCodecPriority,
        videoFilter,
        audioCodecPriority,
        audioFilter,
        isTunneledPlaybackEnabled,
        seekMode,
      ];
}
