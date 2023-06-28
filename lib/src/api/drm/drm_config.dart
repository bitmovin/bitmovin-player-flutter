import 'package:bitmovin_player/src/api/drm/fairplay_config.dart';
import 'package:bitmovin_player/src/api/drm/widevine_config.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'drm_config.g.dart';

@JsonSerializable(explicitToJson: true)
class DrmConfig extends Equatable {
  const DrmConfig({
    this.fairplay,
    this.widevine,
  });

  factory DrmConfig.fromJson(Map<String, dynamic> json) =>
      _$DrmConfigFromJson(json);

  @JsonKey(name: 'fairplay')
  final FairplayConfig? fairplay;

  @JsonKey(name: 'widevine')
  final WidevineConfig? widevine;

  Map<String, dynamic> toJson() => _$DrmConfigToJson(this);

  @override
  List<Object?> get props => [fairplay, widevine];
}
