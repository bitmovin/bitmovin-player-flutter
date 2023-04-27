// ignore_for_file: non_constant_identifier_names

import 'package:bitmovin_sdk/src/models/events/load_event.dart';
import 'package:bitmovin_sdk/src/models/events/loaded_event.dart';
import 'package:bitmovin_sdk/src/models/events/muted_event.dart';
import 'package:bitmovin_sdk/src/models/events/paused_event.dart';
import 'package:bitmovin_sdk/src/models/events/play_event.dart';
import 'package:bitmovin_sdk/src/models/events/playing_event.dart';
import 'package:bitmovin_sdk/src/models/events/seek_event.dart';
import 'package:bitmovin_sdk/src/models/events/seeked_event.dart';
import 'package:bitmovin_sdk/src/models/events/source_added_event.dart';
import 'package:bitmovin_sdk/src/models/events/source_removed_event.dart';
import 'package:bitmovin_sdk/src/models/events/time_changed_event.dart';
import 'package:bitmovin_sdk/src/models/events/unmuted_event.dart';

export 'package:bitmovin_sdk/src/models/events/event.dart';
export 'package:bitmovin_sdk/src/models/events/load_event.dart';
export 'package:bitmovin_sdk/src/models/events/loaded_event.dart';
export 'package:bitmovin_sdk/src/models/events/muted_event.dart';
export 'package:bitmovin_sdk/src/models/events/paused_event.dart';
export 'package:bitmovin_sdk/src/models/events/play_event.dart';
export 'package:bitmovin_sdk/src/models/events/playing_event.dart';
export 'package:bitmovin_sdk/src/models/events/seek_event.dart';
export 'package:bitmovin_sdk/src/models/events/seeked_event.dart';
export 'package:bitmovin_sdk/src/models/events/source_added_event.dart';
export 'package:bitmovin_sdk/src/models/events/source_removed_event.dart';
export 'package:bitmovin_sdk/src/models/events/time_changed_event.dart';
export 'package:bitmovin_sdk/src/models/events/unmuted_event.dart';

abstract class PlayerEvent {
  static LoadEvent Load(Map<String, dynamic> json) {
    return LoadEvent.fromJson(json);
  }

  static LoadedEvent Loaded(Map<String, dynamic> json) {
    return LoadedEvent.fromJson(json);
  }

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

  static UnMutedEvent UnMuted(Map<String, dynamic> json) {
    return UnMutedEvent.fromJson(json);
  }

  static SourceAddedEvent SourceAdded(Map<String, dynamic> json) {
    return SourceAddedEvent.fromJson(json);
  }

  static SourceRemovedEvent SourceRemoved(Map<String, dynamic> json) {
    return SourceRemovedEvent.fromJson(json);
  }

  static SeekEvent Seek(Map<String, dynamic> json) {
    return SeekEvent.fromJson(json);
  }

  static SeekedEvent Seeked(Map<String, dynamic> json) {
    return SeekedEvent.fromJson(json);
  }
}
