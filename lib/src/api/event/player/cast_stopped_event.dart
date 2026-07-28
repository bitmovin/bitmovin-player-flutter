import 'package:bitmovin_player/src/api/event/event.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cast_stopped_event.g.dart';

/// Emitted when casting to a cast-compatible device is stopped.
@JsonSerializable(explicitToJson: true)
class CastStoppedEvent extends Event {
  const CastStoppedEvent({required super.timestamp});

  factory CastStoppedEvent.fromJson(Map<String, dynamic> json) {
    return _$CastStoppedEventFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$CastStoppedEventToJson(this);
}
