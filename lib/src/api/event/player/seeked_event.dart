import 'package:bitmovin_player/src/api/event/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seeked_event.g.dart';

/// Emitted when seeking has finished and data is available to continue
/// playback. Only applies to VoD streams.
@JsonSerializable(explicitToJson: true)
class SeekedEvent extends Event with EquatableMixin {
  const SeekedEvent({
    required super.timestamp,
  });

  factory SeekedEvent.fromJson(Map<String, dynamic> json) {
    return _$SeekedEventFromJson(json);
  }

  @override
  List<Object?> get props => [timestamp];

  @override
  Map<String, dynamic> toJson() => _$SeekedEventToJson(this);
}
