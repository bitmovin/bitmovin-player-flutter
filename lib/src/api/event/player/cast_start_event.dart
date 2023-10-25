import 'package:bitmovin_player/src/api/event/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cast_start_event.g.dart';

/// Emitted when casting is initiated, but the user still needs to choose which
/// device should be used.
@JsonSerializable(explicitToJson: true)
class CastStartEvent extends Event with EquatableMixin {
  const CastStartEvent({required super.timestamp});

  factory CastStartEvent.fromJson(Map<String, dynamic> json) {
    return _$CastStartEventFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$CastStartEventToJson(this);
}
