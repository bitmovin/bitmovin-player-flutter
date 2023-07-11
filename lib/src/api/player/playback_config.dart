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
    this.videoCodecPriority,
    this.audioCodecPriority,
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
  @JsonKey(name: 'isAutoplayEnabled')
  final bool isAutoplayEnabled;

  /// Specifies whether the player should start muted.
  /// Default value is `false`.
  @JsonKey(name: 'isMuted')
  final bool isMuted;

  /// Specifies if time shifting (during live streaming) should be enabled.
  /// Default value is `true`.
  @JsonKey(name: 'isTimeShiftEnabled')
  final bool isTimeShiftEnabled;

  /// The video codec priority where the index has the highest priority.
  /// For a single [SourceConfig] this can be overwritten using
  /// [SourceConfig.videoCodecPriority].
  /// Default value is `null`. In this case the player will use the default that
  /// is provided by the platform.
  ///
  /// This is only supported on Android.
  @JsonKey(name: 'videoCodecPriority')
  final List<String>? videoCodecPriority;

  /// The audio codec priority where the first index has the highest priority.
  /// For a single [SourceConfig] this can be overwritten using
  /// [SourceConfig.audioCodecPriority].
  /// Default value is `null`. In this case the player will use the default that
  /// is provided by the platform.
  ///
  /// This is only supported on Android.
  @JsonKey(name: 'audioCodecPriority')
  final List<String>? audioCodecPriority;

  /// Specifies if tunneled playback should be enabled.
  /// Default value is `false`.
  ///
  /// This is only supported on Android. This property is ignored for Android
  /// versions below LOLLIPOP (21) or when VR sources are scheduled.
  @JsonKey(name: 'isTunneledPlaybackEnabled')
  final bool isTunneledPlaybackEnabled;

  /// The [SeekMode] that will be used.
  /// Default value is [SeekMode.exact].
  ///
  /// This is only available on Android.
  @JsonKey(name: 'seekMode')
  final SeekMode seekMode;

  /// Specifies how strictly potentially unsupported audio tracks and qualities
  /// are filtered out of a playback session.
  /// Default value is [MediaFilter.loose].
  ///
  /// This is only supported on Android.
  @JsonKey(name: 'audioFilter')
  final MediaFilter audioFilter;

  /// Specifies how strictly potentially unsupported video qualities are
  /// filtered out of a playback session.
  /// Default value is [MediaFilter.loose].
  ///
  /// This is only supported on Android.
  @JsonKey(name: 'videoFilter')
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
