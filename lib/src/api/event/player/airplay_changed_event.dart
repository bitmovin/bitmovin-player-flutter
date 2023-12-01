import 'package:bitmovin_player/src/api/event/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'airplay_changed_event.g.dart';

/// Emitted when AirPlay playback starts or stops.
@JsonSerializable(explicitToJson: true)
class AirPlayChangedEvent extends Event with EquatableMixin {
  const AirPlayChangedEvent( {
    required super.timestamp,
    required this.isAirPlayActive,
    required this.time,
  });

  factory AirPlayChangedEvent.fromJson(Map<String, dynamic> json) {
    return _$AirPlayChangedEventFromJson(json);
  }

  /// Indicates whether AirPlay is active.
  final bool isAirPlayActive;

  // The current playback time (in seconds).
  final double time;

  @override
  Map<String, dynamic> toJson() => _$AirPlayChangedEventToJson(this);

  @override
  List<Object?> get props => [timestamp, isAirPlayActive, time];
}
