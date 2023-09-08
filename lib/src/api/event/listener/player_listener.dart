// ignore_for_file: avoid_setters_without_getters

import 'package:bitmovin_player/bitmovin_player.dart';

/// Defines events that can be emitted by the player.
abstract class PlayerListener {
  /// Receives any event that is emitted by the player.
  set onEvent(void Function(Event) func);

  /// See [SourceAddedEvent] for details on this event.
  set onSourceAdded(void Function(SourceAddedEvent) func);

  /// See [SourceRemovedEvent] for details on this event.
  set onSourceRemoved(void Function(SourceRemovedEvent) func);

  /// See [SourceLoadEvent] for details on this event.
  set onSourceLoad(void Function(SourceLoadEvent) func);

  /// See [SourceLoadedEvent] for details on this event.
  set onSourceLoaded(void Function(SourceLoadedEvent) func);

  /// See [SourceUnloadedEvent] for details on this event.
  set onSourceUnloaded(void Function(SourceUnloadedEvent) func);

  /// See [SourceWarningEvent] for details on this event.
  set onSourceWarning(void Function(SourceWarningEvent) func);

  /// See [SourceErrorEvent] for details on this event.
  set onSourceError(void Function(SourceErrorEvent) func);

  /// See [SourceInfoEvent] for details on this event.
  set onSourceInfo(void Function(SourceInfoEvent) func);

  /// See [PlayEvent] for details on this event.
  set onPlay(void Function(PlayEvent) func);

  /// See [PlayingEvent] for details on this event.
  set onPlaying(void Function(PlayingEvent) func);

  /// See [PausedEvent] for details on this event.
  set onPaused(void Function(PausedEvent) func);

  /// See [MutedEvent] for details on this event.
  set onMuted(void Function(MutedEvent) func);

  /// See [UnmutedEvent] for details on this event.
  set onUnmuted(void Function(UnmutedEvent) func);

  /// See [SeekEvent] for details on this event.
  set onSeek(void Function(SeekEvent) func);

  /// See [SeekedEvent] for details on this event.
  set onSeeked(void Function(SeekedEvent) func);

  /// See [TimeShiftEvent] for details on this event.
  set onTimeShift(void Function(TimeShiftEvent) func);

  /// See [TimeShiftedEvent] for details on this event.
  set onTimeShifted(void Function(TimeShiftedEvent) func);

  /// See [TimeChangedEvent] for details on this event.
  set onTimeChanged(void Function(TimeChangedEvent) func);

  /// See [PlaybackFinishedEvent] for details on this event.
  set onPlaybackFinished(void Function(PlaybackFinishedEvent) func);

  /// See [ErrorEvent] for details on this event.
  set onError(void Function(ErrorEvent) func);

  /// See [InfoEvent] for details on this event.
  set onInfo(void Function(InfoEvent) func);

  /// See [WarningEvent] for details on this event.
  set onWarning(void Function(WarningEvent) func);

  /// See [ReadyEvent] for details on this event.
  set onReady(void Function(ReadyEvent) func);
}
