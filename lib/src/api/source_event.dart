// ignore_for_file: non_constant_identifier_names

import 'package:bitmovin_sdk/src/api/source/event/source_added_event.dart';
import 'package:bitmovin_sdk/src/api/source/event/source_error_event.dart';
import 'package:bitmovin_sdk/src/api/source/event/source_info_event.dart';
import 'package:bitmovin_sdk/src/api/source/event/source_load_event.dart';
import 'package:bitmovin_sdk/src/api/source/event/source_loaded_event.dart';
import 'package:bitmovin_sdk/src/api/source/event/source_removed_event.dart';
import 'package:bitmovin_sdk/src/api/source/event/source_unloaded_event.dart';
import 'package:bitmovin_sdk/src/api/source/event/source_warning_event.dart';

export 'package:bitmovin_sdk/src/api/source/event/source_added_event.dart';
export 'package:bitmovin_sdk/src/api/source/event/source_error_event.dart';
export 'package:bitmovin_sdk/src/api/source/event/source_info_event.dart';
export 'package:bitmovin_sdk/src/api/source/event/source_load_event.dart';
export 'package:bitmovin_sdk/src/api/source/event/source_loaded_event.dart';
export 'package:bitmovin_sdk/src/api/source/event/source_removed_event.dart';
export 'package:bitmovin_sdk/src/api/source/event/source_unloaded_event.dart';
export 'package:bitmovin_sdk/src/api/source/event/source_warning_event.dart';

class SourceEvent {
  static SourceAddedEvent SourceAdded(Map<String, dynamic> json) {
    return SourceAddedEvent.fromJson(json);
  }

  static SourceRemovedEvent SourceRemoved(Map<String, dynamic> json) {
    return SourceRemovedEvent.fromJson(json);
  }

  static SourceLoadEvent Load(Map<String, dynamic> json) {
    return SourceLoadEvent.fromJson(json);
  }

  static SourceLoadedEvent Loaded(Map<String, dynamic> json) {
    return SourceLoadedEvent.fromJson(json);
  }

  static SourceUnloadedEvent Unloaded(Map<String, dynamic> json) {
    return SourceUnloadedEvent.fromJson(json);
  }

  static SourceInfoEvent SourceInfo(Map<String, dynamic> json) {
    return SourceInfoEvent.fromJson(json);
  }

  static SourceWarningEvent SourceWarning(Map<String, dynamic> json) {
    return SourceWarningEvent.fromJson(json);
  }

  static SourceErrorEvent SourceError(Map<String, dynamic> json) {
    return SourceErrorEvent.fromJson(json);
  }
}
