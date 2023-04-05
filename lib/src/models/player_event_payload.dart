import 'package:bitmovin_sdk/src/enums/player_event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'player_event_payload.g.dart';

@JsonSerializable(explicitToJson: true)
class PlayerEventPayload extends Equatable {
  const PlayerEventPayload({
    this.type,
    this.currentTime,
    this.duration,
    this.code,
    this.message,
    this.data,
  });

  factory PlayerEventPayload.fromJson(Map<String, dynamic> json) {
    return _$PlayerEventPayloadFromJson(json);
  }

  /// Indicates what type of event is currently being done.
  final PlayerEvent? type;

  /// Current time in seconds of the playback
  final double? currentTime;

  /// Max duration of the playback.
  final double? duration;

  final String? code;

  final String? message;

  final dynamic data;

  Map<String, dynamic> toJson() => _$PlayerEventPayloadToJson(this);

  @override
  List<Object?> get props => [
        type,
        currentTime,
        duration,
        message,
        code,
        data,
      ];
}
