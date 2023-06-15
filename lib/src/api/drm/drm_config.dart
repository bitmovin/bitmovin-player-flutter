import 'package:bitmovin_sdk/src/api/drm/fairplay_config.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'drm_config.g.dart';

@JsonSerializable(explicitToJson: true)
class DrmConfig extends Equatable {
  const DrmConfig({
    this.fairplay,
  });

  factory DrmConfig.fromJson(Map<String, dynamic> json) =>
      _$DrmConfigFromJson(json);

  final FairplayConfig? fairplay;

  Map<String, dynamic> toJson() => _$DrmConfigToJson(this);

  @override
  List<Object?> get props => [fairplay];
}
