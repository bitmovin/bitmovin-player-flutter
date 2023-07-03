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
  Future<void> seek(double time);

  /// The current playback time of the active [Source] in seconds.
  Future<double> currentTime();

  /// The duration of the active [Source] in seconds.
  Future<double> duration();
}
