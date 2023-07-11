import 'package:json_annotation/json_annotation.dart';

/// Represents the mode the player uses to seek.
/// This is only available on Android.
enum SeekMode {
  /// For exact seeking.
  @JsonValue('Exact')
  exact,

  /// For seeking to the closest sync point.
  @JsonValue('ClosestSync')
  closesSync,

  /// For seeking to the sync point immediately before a requested seek
  /// position.
  @JsonValue('PreviousSync')
  previousSync,

  /// For seeking to the sync point immediately after a requested seek position.
  @JsonValue('NextSync')
  nextSync,
}
