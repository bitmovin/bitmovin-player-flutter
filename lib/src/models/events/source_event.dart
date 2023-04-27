// ignore_for_file: non_constant_identifier_names

import 'package:bitmovin_sdk/src/models/events/load_event.dart';
import 'package:bitmovin_sdk/src/models/events/loaded_event.dart';

abstract class SourceEvent {
  static LoadEvent Load(Map<String, dynamic> json) {
    return LoadEvent.fromJson(json);
  }

  static LoadedEvent Loadeded(Map<String, dynamic> json) {
    return LoadedEvent.fromJson(json);
  }
}
