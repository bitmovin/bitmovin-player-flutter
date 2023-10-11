import 'package:bitmovin_player/src/api/event/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cast_available_event.g.dart';

/// Emitted when casting to a cast-compatible device is available.
@JsonSerializable(explicitToJson: true)
class CastAvailableEvent extends Event with EquatableMixin {
  const CastAvailableEvent({required super.timestamp});

  factory CastAvailableEvent.fromJson(Map<String, dynamic> json) {
    return _$CastAvailableEventFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$CastAvailableEventToJson(this);

  @override
  List<Object?> get props => [timestamp];
}
