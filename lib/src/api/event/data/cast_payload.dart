import 'package:bitmovin_player/src/source.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cast_payload.g.dart';

/// Represents a seeking position within a [Source].
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
  @JsonKey(name: 'currentTime')
  final double currentTime;

  /// The name of the chosen cast device.
  @JsonKey(name: 'deviceName')
  final String? deviceName;

  Map<String, dynamic> toJson() => _$CastPayloadToJson(this);

  @override
  List<Object?> get props => [currentTime, deviceName];
}
