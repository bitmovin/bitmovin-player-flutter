// ignore_for_file: avoid_setters_without_getters

import 'package:bitmovin_sdk/src/configs/source_config.dart';
import 'package:bitmovin_sdk/src/models/source.dart';

abstract class PlayerEventsInterface {
  set onTimeChanged(void Function(dynamic data) func);

  set onLoad(void Function(dynamic data) func);

  set onLoaded(void Function(dynamic data) func);

  set onSourceUnLoaded(void Function(dynamic data) func);

  set onPlay(void Function(dynamic data) func);

  set onPlaying(void Function(dynamic data) func);

  set onPaused(void Function(dynamic data) func);

  set onMuted(void Function(dynamic data) func);

  set onUnMuted(void Function(dynamic data) func);

  set onSourceAdded(void Function(dynamic data) func);

  set onSourceRemoved(void Function(dynamic data) func);

  set onSeek(void Function(dynamic data) func);

  set onSeeked(void Function(dynamic data) func);

  set onPlaybackFinished(void Function(dynamic data) func);

  set onSourceWarning(void Function(dynamic data) func);

  set onSourceError(void Function(dynamic data) func);

  set onSourceInfo(void Function(dynamic data) func);

  set onError(void Function(dynamic data) func);

  set onInfo(void Function(dynamic data) func);

  set onWarning(void Function(dynamic data) func);

  set onReady(void Function(dynamic data) func);
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
