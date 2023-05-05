// ignore_for_file: non_constant_identifier_names

import 'package:bitmovin_sdk/src/api/player/event/error_event.dart';
import 'package:bitmovin_sdk/src/api/player/event/info_event.dart';
import 'package:bitmovin_sdk/src/api/player/event/muted_event.dart';
import 'package:bitmovin_sdk/src/api/player/event/paused_event.dart';
import 'package:bitmovin_sdk/src/api/player/event/play_event.dart';
import 'package:bitmovin_sdk/src/api/player/event/playback_finished_event.dart';
import 'package:bitmovin_sdk/src/api/player/event/playing_event.dart';
import 'package:bitmovin_sdk/src/api/player/event/ready_event.dart';
import 'package:bitmovin_sdk/src/api/player/event/seek_event.dart';
import 'package:bitmovin_sdk/src/api/player/event/seeked_event.dart';
import 'package:bitmovin_sdk/src/api/player/event/time_changed_event.dart';
import 'package:bitmovin_sdk/src/api/player/event/unmuted_event.dart';
import 'package:bitmovin_sdk/src/api/player/event/warning_event.dart';

export 'package:bitmovin_sdk/src/api/player/event/error_event.dart';
export 'package:bitmovin_sdk/src/api/player/event/info_event.dart';
export 'package:bitmovin_sdk/src/api/player/event/muted_event.dart';
export 'package:bitmovin_sdk/src/api/player/event/paused_event.dart';
export 'package:bitmovin_sdk/src/api/player/event/play_event.dart';
export 'package:bitmovin_sdk/src/api/player/event/playback_finished_event.dart';
export 'package:bitmovin_sdk/src/api/player/event/playing_event.dart';
export 'package:bitmovin_sdk/src/api/player/event/ready_event.dart';
export 'package:bitmovin_sdk/src/api/player/event/seek_event.dart';
export 'package:bitmovin_sdk/src/api/player/event/seeked_event.dart';
export 'package:bitmovin_sdk/src/api/player/event/time_changed_event.dart';
export 'package:bitmovin_sdk/src/api/player/event/unmuted_event.dart';
export 'package:bitmovin_sdk/src/api/player/event/warning_event.dart';

abstract class PlayerEvent {
  static PlayEvent Play(Map<String, dynamic> json) {
    return PlayEvent.fromJson(json);
  }

  static PlayingEvent Playing(Map<String, dynamic> json) {
    return PlayingEvent.fromJson(json);
  }

  static TimeChangedEvent TimeChanged(Map<String, dynamic> json) {
    return TimeChangedEvent.fromJson(json);
  }

  static PausedEvent Paused(Map<String, dynamic> json) {
    return PausedEvent.fromJson(json);
  }

  static MutedEvent Muted(Map<String, dynamic> json) {
    return MutedEvent.fromJson(json);
  }

  static UnmutedEvent Unmuted(Map<String, dynamic> json) {
    return UnmutedEvent.fromJson(json);
  }

  static SeekEvent Seek(Map<String, dynamic> json) {
    return SeekEvent.fromJson(json);
  }

  static SeekedEvent Seeked(Map<String, dynamic> json) {
    return SeekedEvent.fromJson(json);
  }

  static PlaybackFinishedEvent PlaybackFinished(Map<String, dynamic> json) {
    return PlaybackFinishedEvent.fromJson(json);
  }

  static ReadyEvent Ready(Map<String, dynamic> json) {
    return ReadyEvent.fromJson(json);
  }

  static InfoEvent Info(Map<String, dynamic> json) {
    return InfoEvent.fromJson(json);
  }

  static WarningEvent Warning(Map<String, dynamic> json) {
    return WarningEvent.fromJson(json);
  }

  static ErrorEvent Error(Map<String, dynamic> json) {
    return ErrorEvent.fromJson(json);
  }
}
