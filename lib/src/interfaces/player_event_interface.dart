// ignore_for_file: avoid_setters_without_getters

import 'package:bitmovin_sdk/src/api/player_event.dart';
import 'package:bitmovin_sdk/src/api/source/source.dart';
import 'package:bitmovin_sdk/src/api/source_config.dart';
import 'package:bitmovin_sdk/src/api/source_event.dart';

abstract class PlayerEventsInterface {
  set onSourceAdded(void Function(SourceAddedEvent data) func);

  set onSourceRemoved(void Function(SourceRemovedEvent data) func);

  set onSourceLoad(void Function(SourceLoadEvent data) func);

  set onSourceLoaded(void Function(SourceLoadedEvent data) func);

  set onSourceUnloaded(void Function(SourceUnloadedEvent data) func);

  set onSourceWarning(void Function(SourceWarningEvent data) func);

  set onSourceError(void Function(SourceErrorEvent data) func);

  set onSourceInfo(void Function(SourceInfoEvent data) func);

  set onPlay(void Function(PlayEvent data) func);

  set onPlaying(void Function(PlayingEvent data) func);

  set onPaused(void Function(PausedEvent data) func);

  set onMuted(void Function(MutedEvent data) func);

  set onUnmuted(void Function(UnmutedEvent data) func);

  set onSeek(void Function(SeekEvent data) func);

  set onSeeked(void Function(SeekedEvent data) func);

  set onTimeChanged(void Function(TimeChangedEvent data) func);

  set onPlaybackFinished(void Function(PlaybackFinishedEvent data) func);

  set onError(void Function(ErrorEvent data) func);

  set onInfo(void Function(InfoEvent data) func);

  set onWarning(void Function(WarningEvent data) func);

  set onReady(void Function(ReadyEvent data) func);
}

abstract class PlayerInterface {
  Future<void> loadWithSource(Source source);
  Future<void> loadWithSourceConfig(SourceConfig sourceConfig);
  Future<void> play();
  Future<void> pause();
  Future<void> mute();
  Future<void> unmute();
  Future<void> seek(double time);
  Future<double> currentTime();
  Future<double> duration();
}
