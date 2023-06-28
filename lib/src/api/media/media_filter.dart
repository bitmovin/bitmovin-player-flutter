import 'package:json_annotation/json_annotation.dart';

/// Defines how strictly potentially unsupported media tracks and qualities are
/// filtered out of a playback session.
enum MediaFilter {
  /// Filters out media tracks and qualities that are definitely and potentially
  /// not supported.
  @JsonValue('None')
  none,

  /// Filters out media tracks and qualities that are definitely not supported,
  /// but keeps those that are potentially supported.
  @JsonValue('Loose')
  loose,

  /// Does not filter any media tracks or qualities.
  @JsonValue('Strict')
  strict,
}

/// @nodoc
extension MediaFilterExtension on MediaFilter {
  static const names = {
    MediaFilter.none: 'None',
    MediaFilter.loose: 'Loose',
    MediaFilter.strict: 'Strict',
  };

  String? get name => names[this];
}
