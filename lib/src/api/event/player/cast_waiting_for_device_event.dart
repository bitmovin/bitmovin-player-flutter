import 'package:bitmovin_player/src/api/event/data/cast_payload.dart';
import 'package:bitmovin_player/src/api/event/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cast_waiting_for_device_event.g.dart';

/// Emitted when a cast-compatible device has been chosen and the player is
/// waiting for the device to get ready for playback.
@JsonSerializable(explicitToJson: true)
class CastWaitingForDeviceEvent extends Event with EquatableMixin {
  const CastWaitingForDeviceEvent({
    required this.castPayload,
    required super.timestamp,
  });

  factory CastWaitingForDeviceEvent.fromJson(Map<String, dynamic> json) {
    return _$CastWaitingForDeviceEventFromJson(json);
  }

  /// The [CastPayload] object for the event.
  final CastPayload castPayload;

  @override
  Map<String, dynamic> toJson() => _$CastWaitingForDeviceEventToJson(this);
}
