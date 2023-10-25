import 'package:bitmovin_player/src/api/event/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cast_time_updated_event.g.dart';

/// Emitted when the time update from the currently used
/// cast-compatible device is received.
@JsonSerializable(explicitToJson: true)
class CastTimeUpdatedEvent extends Event with EquatableMixin {
  const CastTimeUpdatedEvent({required super.timestamp});

  factory CastTimeUpdatedEvent.fromJson(Map<String, dynamic> json) {
    return _$CastTimeUpdatedEventFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$CastTimeUpdatedEventToJson(this);
}
