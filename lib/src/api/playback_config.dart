import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'playback_config.g.dart';

/// Configures the playback behavior of the player.
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
      'mp4a.40',
    ],
    this.isTunneledPlaybackEnabled = false,
    this.seekMode = SeekMode.exact,
    this.audioFilter = MediaFilter.loose,
    this.videoFilter = MediaFilter.loose,
  });

  factory PlaybackConfig.fromJson(Map<String, dynamic> json) {
    return _$PlaybackConfigFromJson(json);
  }

  /// Specifies whether autoplay is enabled.
  /// Default value is `false`.
  @JsonKey(name: 'isAutoplayEnabled', defaultValue: false)
  final bool? isAutoplayEnabled;

  /// Specifies whether the player should start muted.
  /// Default value is `false`.
  @JsonKey(name: 'isMuted', defaultValue: false)
  final bool? isMuted;

  /// Specifies if time shifting (during live streaming) should be enabled.
  /// Default value is `true`.
  @JsonKey(name: 'isTimeShiftEnabled', defaultValue: true)
  final bool? isTimeShiftEnabled;

  /// The video codec priority where the index has the highest priority.
  /// For a single [SourceConfig] this can be overwritten using
  /// [SourceConfig.videoCodecPriority].
  ///
  /// This is only supported on Android.
  @JsonKey(name: 'videoCodecPriority', defaultValue: [])
  final List<String>? videoCodecPriority;

  /// The audio codec priority where the first index has the highest priority.
  /// For a single [SourceConfig] this can be overwritten using
  /// [SourceConfig.audioCodecPriority].
  ///
  /// This is only supported on Android.
  @JsonKey(name: 'audioCodecPriority', defaultValue: [])
  final List<String>? audioCodecPriority;

  /// Specifies if tunneled playback should be enabled.
  ///
  /// This is only supported on Android. This property is ignored for Android
  /// versions below LOLLIPOP (21) or when VR sources are scheduled.
  @JsonKey(name: 'isTunneledPlaybackEnabled', defaultValue: false)
  final bool? isTunneledPlaybackEnabled;

  /// The [SeekMode] that will be used.
  /// Default value is [SeekMode.exact].
  ///
  /// This is only available on Android.
  @JsonKey(name: 'seekMode', defaultValue: SeekMode.exact)
  final SeekMode? seekMode;

  /// Specifies how strictly potentially unsupported audio tracks and qualities
  /// are filtered out of a playback session.
  ///
  /// This is only supported on Android.
  @JsonKey(name: 'audioFilter', defaultValue: MediaFilter.loose)
  final MediaFilter audioFilter;

  /// Specifies how strictly potentially unsupported video qualities are
  /// filtered out of a playback session.
  ///
  /// This is only supported on Android.
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
