import 'package:bitmovin_player/bitmovin_player.dart';

/// Defines the API for the player.
abstract class PlayerApi {
  /// The player config.
  PlayerConfig get config;

  /// Starts a new playback session with the provided [Source].
  Future<void> loadSource(Source source);

  /// Starts a new playback session with a [Source] that is created based on
  /// the provided [SourceConfig].
  Future<void> loadSourceConfig(SourceConfig sourceConfig);

  /// Starts or resumes playback.
  Future<void> play();

  /// Pauses playback.
  Future<void> pause();

  /// Mutes the player.
  Future<void> mute();

  /// Unmutes the player.
  Future<void> unmute();

  /// Seeks to the given playback time in seconds.
  /// Must not be greater than the duration of the active [Source].
  /// Only applicable for VOD. For live streams, use [timeShift] and
  /// [setTimeShift].
  Future<void> seek(double time);

  /// The current playback time of the active [Source] in seconds.
  /// For VoD streams the returned time ranges between 0 and the duration of
  /// the asset. For live streams, a Unix timestamp denoting the current
  /// playback position is returned.
  Future<double> get currentTime;

  /// The duration of the active [Source] in seconds. Will be [double.infinity]
  /// for live streams.
  Future<double> get duration;

  /// Returns the limit in seconds for time shifting. Is either negative or 0.
  /// Only applicable for live streams.
  Future<double> get maxTimeShift;

  /// Returns the the current time shift value of the player in seconds. It
  /// describes the offset from the live edge. The returned value is within
  /// [maxTimeShift] (which is a negative value) and 0 (the live edge).
  /// Only applicable for live streams.
  Future<double> get timeShift;

  /// Shifts the playback time to the given offset in seconds from the live
  /// edge. Has to be within [maxTimeShift] (which is a negative value) and 0.
  /// The offset can be positive and is then interpreted as a UNIX timestamp in
  /// seconds. The value has to be within the time shift window, as specified by
  /// [maxTimeShift].
  /// Only applicable for live streams. For VOD, use [seek].
  Future<void> setTimeShift(double timeShift);

  /// Whether the currently active [Source] is a live stream.
  Future<bool> get isLive;

  /// Whether the player is currently playing, i.e. has started playback and is
  /// not paused.
  Future<bool> get isPlaying;

  /// Whether the player is currently paused, i.e. has started playback but is
  /// currently paused.
  Future<bool> get isPaused;

  /// Whether the player is muted.
  Future<bool> get isMuted;

  /// A list of all available [SubtitleTrack]s of the active [Source],
  /// including "off" subtitle track.
  Future<List<SubtitleTrack>> get availableSubtitles;

  /// The currently selected [SubtitleTrack].
  Future<SubtitleTrack> get subtitle;

  /// Sets the currently selected [SubtitleTrack] based on the provided [id].
  /// Using `null` as [id] disables subtitles. A list of currently available
  /// [SubtitleTrack]s can be retrieved via [availableSubtitles].
  Future<void> setSubtitle(String? id);

  /// Removes the existing [SubtitleTrack] specified by [id]. If the track is
  /// currently active, it will be deactivated and then removed. If no
  /// [SubtitleTrack] with the given [id] exists, the call will be ignored.
  /// Using this API removes the [SubtitleTrack] from the [availableSubtitles],
  /// use [setSubtitle] to disable an active [SubtitleTrack].
  Future<void> removeSubtitle(String id);

  /// Provides access to Analytics related functionality.
  AnalyticsApi get analytics;

  /// Whether casting to a cast-compatible remote device is available.
  /// [CastAvailableEvent] signals when casting becomes available.
  Future<bool> get isCastAvailable;

  /// Whether video is currently being casted to a remote device and not played
  /// locally.
  Future<bool> get isCasting;

  /// Initiates casting the current video to a cast-compatible remote device.
  /// The user has to choose to which device it should be sent.
  Future<void> castVideo();

  /// Stops casting the current video.
  Future<void> castStop();

  /// Returns `true` when media is played externally using AirPlay.
  ///
  /// Only available on iOS.
  Future<bool> get isAirPlayActive;

  /// Returns `true` when AirPlay is available.
  ///
  /// Only available on iOS.
  Future<bool> get isAirPlayAvailable;

  /// Shows the AirPlay playback target picker.
  ///
  /// Only available on iOS.
  Future<void> showAirPlayTargetPicker();

  /// Dispose the player instance when no longer needed.
  Future<void> dispose();
}
