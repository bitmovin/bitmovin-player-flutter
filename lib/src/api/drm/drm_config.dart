import 'package:bitmovin_player/src/api/drm/fairplay_config.dart';
import 'package:bitmovin_player/src/api/drm/widevine_config.dart';
import 'package:bitmovin_player/src/api/source/source_remote_control_config.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'drm_config.g.dart';

/// Provides DRM configuration for the player.
/// - On iOS, FairPlay is supported. For Casting, Widevine is supported when it
///   is configured as part of a [SourceRemoteControlConfig.castSourceConfig].
/// - On Android, Widevine is supported.
///
/// See [FairplayConfig] and [WidevineConfig] for more information.
@JsonSerializable(explicitToJson: true)
class DrmConfig extends Equatable {
  const DrmConfig({
    this.fairplay,
    this.widevine,
  });

  factory DrmConfig.fromJson(Map<String, dynamic> json) =>
      _$DrmConfigFromJson(json);

  /// Configuration for FairPlay DRM.
  @JsonKey(name: 'fairplay')
  final FairplayConfig? fairplay;

  /// Configuration for Widevine DRM.
  @JsonKey(name: 'widevine')
  final WidevineConfig? widevine;

  Map<String, dynamic> toJson() => _$DrmConfigToJson(this);

  @override
  List<Object?> get props => [fairplay, widevine];
}
