import 'package:bitmovin_player/src/api/event/data/seek_position.dart';
import 'package:bitmovin_player/src/api/event/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seek_event.g.dart';

/// Emitted when the player starts seeking. Only applies to VoD streams.
@JsonSerializable(explicitToJson: true)
class SeekEvent extends Event with EquatableMixin {
  const SeekEvent({
    required this.from,
    required this.to,
    required super.timestamp,
  });
  factory SeekEvent.fromJson(Map<String, dynamic> json) {
    return _$SeekEventFromJson(json);
  }

  /// The current position.
  @JsonKey(name: 'from')
  final SeekPosition from;

  /// The target position.
  @JsonKey(name: 'to')
  final SeekPosition to;

  @override
  List<Object?> get props => [from, to, timestamp];

  @override
  Map<String, dynamic> toJson() => _$SeekEventToJson(this);
}
