import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source_remote_control_config.g.dart';

/// The remote control config for a [Source].
/// Only available on iOS.
@JsonSerializable(explicitToJson: true)
class SourceRemoteControlConfig extends Equatable {
  const SourceRemoteControlConfig({
    required this.castSourceConfig,
  });

  /// Creates a [SourceRemoteControlConfig] from json.
  factory SourceRemoteControlConfig.fromJson(Map<String, dynamic> json) =>
      _$SourceRemoteControlConfigFromJson(json);

  /// The [SourceConfig] for casting.
  /// Enables to play different content when casting.
  /// This can be useful when the remote playback device supports different
  /// streaming formats, DRM systems, etc. than the local device.
  /// If not set, the local source config will be used for casting.
  final SourceConfig? castSourceConfig;

  Map<String, dynamic> toJson() => _$SourceRemoteControlConfigToJson(this);

  @override
  List<Object?> get props => [castSourceConfig];
}
