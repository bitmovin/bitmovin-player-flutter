import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/api/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'info_event.g.dart';

/// The common supertype implemented by all different info events that are
/// emitted by the [Player] or [Source].
@JsonSerializable(explicitToJson: true)
class InfoEvent extends Event with EquatableMixin {
  const InfoEvent({
    required super.timestamp,
    this.message,
  });

  factory InfoEvent.fromJson(Map<String, dynamic> json) {
    return _$InfoEventFromJson(json);
  }

  /// A natural language message detailing the reason and origin of this event.
  @JsonKey(name: 'message', defaultValue: null)
  final String? message;

  @override
  List<Object?> get props => [message, timestamp];

  @override
  Map<String, dynamic> toJson() => _$InfoEventToJson(this);
}
