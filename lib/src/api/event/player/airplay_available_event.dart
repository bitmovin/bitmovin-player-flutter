import 'package:bitmovin_player/src/api/event/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'airplay_available_event.g.dart';

/// Emitted when AirPlay is available.
@JsonSerializable(explicitToJson: true)
class AirPlayAvailableEvent extends Event with EquatableMixin {
  const AirPlayAvailableEvent({required super.timestamp});

  factory AirPlayAvailableEvent.fromJson(Map<String, dynamic> json) {
    return _$AirPlayAvailableEventFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$AirPlayAvailableEventToJson(this);
}
