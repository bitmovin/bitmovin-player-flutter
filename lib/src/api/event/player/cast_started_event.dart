import 'package:bitmovin_player/src/api/event/event.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cast_started_event.g.dart';

/// Emitted when the cast app is launched successfully.
@JsonSerializable(explicitToJson: true)
class CastStartedEvent extends Event {
  const CastStartedEvent({
    required super.timestamp,
    this.deviceName,
  });

  factory CastStartedEvent.fromJson(Map<String, dynamic> json) {
    return _$CastStartedEventFromJson(json);
  }

  /// The name of the cast device on which the app was launched.
  final String? deviceName;

  @override
  Map<String, dynamic> toJson() => _$CastStartedEventToJson(this);

  @override
  List<Object?> get props => [timestamp, deviceName];
}
