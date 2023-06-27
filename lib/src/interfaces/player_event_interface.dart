// ignore_for_file: avoid_setters_without_getters

import 'package:bitmovin_player/src/api/player_event.dart';
import 'package:bitmovin_player/src/api/source/source.dart';
import 'package:bitmovin_player/src/api/source_config.dart';
import 'package:bitmovin_player/src/api/source_event.dart';

/// Defines events that can be emitted by the player.
abstract class PlayerEventsInterface {
  /// See [SourceAddedEvent] for details on this event.
  set onSourceAdded(void Function(SourceAddedEvent data) func);

  /// See [SourceRemovedEvent] for details on this event.
  set onSourceRemoved(void Function(SourceRemovedEvent data) func);

  /// See [SourceLoadEvent] for details on this event.
  set onSourceLoad(void Function(SourceLoadEvent data) func);

  /// See [SourceLoadedEvent] for details on this event.
  set onSourceLoaded(void Function(SourceLoadedEvent data) func);

  /// See [SourceUnloadedEvent] for details on this event.
  set onSourceUnloaded(void Function(SourceUnloadedEvent data) func);

  /// See [SourceWarningEvent] for details on this event.
  set onSourceWarning(void Function(SourceWarningEvent data) func);

  /// See [SourceErrorEvent] for details on this event.
  set onSourceError(void Function(SourceErrorEvent data) func);

  /// See [SourceInfoEvent] for details on this event.
  set onSourceInfo(void Function(SourceInfoEvent data) func);

  /// See [PlayEvent] for details on this event.
  set onPlay(void Function(PlayEvent data) func);

  /// See [PlayingEvent] for details on this event.
  set onPlaying(void Function(PlayingEvent data) func);

  /// See [PausedEvent] for details on this event.
  set onPaused(void Function(PausedEvent data) func);

  /// See [MutedEvent] for details on this event.
  set onMuted(void Function(MutedEvent data) func);

  /// See [UnmutedEvent] for details on this event.
  set onUnmuted(void Function(UnmutedEvent data) func);

  /// See [SeekEvent] for details on this event.
  set onSeek(void Function(SeekEvent data) func);

  /// See [SeekedEvent] for details on this event.
  set onSeeked(void Function(SeekedEvent data) func);

  /// See [TimeChangedEvent] for details on this event.
  set onTimeChanged(void Function(TimeChangedEvent data) func);

  /// See [PlaybackFinishedEvent] for details on this event.
  set onPlaybackFinished(void Function(PlaybackFinishedEvent data) func);

  /// See [ErrorEvent] for details on this event.
  set onError(void Function(ErrorEvent data) func);

  /// See [InfoEvent] for details on this event.
  set onInfo(void Function(InfoEvent data) func);

  /// See [WarningEvent] for details on this event.
  set onWarning(void Function(WarningEvent data) func);

  /// See [ReadyEvent] for details on this event.
  set onReady(void Function(ReadyEvent data) func);
}

/// @nodoc
abstract class PlayerInterface {
  Future<void> loadSource(Source source);
  Future<void> loadSourceConfig(SourceConfig sourceConfig);
  Future<void> play();
  Future<void> pause();
  Future<void> mute();
  Future<void> unmute();
  Future<void> seek(double time);
  Future<double> currentTime();
  Future<double> duration();
}
