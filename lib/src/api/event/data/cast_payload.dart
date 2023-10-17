import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cast_payload.g.dart';

/// Contains information for the `CastWaitingForDeviceEvent`.
@JsonSerializable(explicitToJson: true)
class CastPayload extends Equatable {
  const CastPayload({
    required this.currentTime,
    this.deviceName,
  });

  factory CastPayload.fromJson(Map<String, dynamic> json) {
    return _$CastPayloadFromJson(json);
  }

  /// The current time in seconds.
  final double currentTime;

  /// The name of the chosen cast device.
  final String? deviceName;

  Map<String, dynamic> toJson() => _$CastPayloadToJson(this);

  @override
  List<Object?> get props => [currentTime, deviceName];
}
