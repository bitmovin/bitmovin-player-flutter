import 'package:bitmovin_player/src/api/ui/scaling_mode.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'style_config.g.dart';

@JsonSerializable(explicitToJson: true)
class StyleConfig extends Equatable {
  const StyleConfig({
    this.isUiEnabled = true,
    this.isHideFirstFrame = false,
    this.playerUiCss,
    this.playerUiJs,
    this.supplementalPlayerUiCss,
    this.scalingMode = ScalingMode.fit,
  });

  factory StyleConfig.fromJson(Map<String, dynamic> json) {
    return _$StyleConfigFromJson(json);
  }

  @JsonKey(name: 'isUiEnabled', defaultValue: true)
  final bool isUiEnabled;

  @JsonKey(name: 'playerUiCss', defaultValue: null)
  final String? playerUiCss;

  @JsonKey(name: 'playerUiJs', defaultValue: null)
  final String? playerUiJs;

  @JsonKey(name: 'supplementalPlayerUiCss', defaultValue: null)
  final String? supplementalPlayerUiCss;

  @JsonKey(name: 'isHideFirstFrame', defaultValue: null)
  final bool isHideFirstFrame;

  @JsonKey(name: 'scalingMode', defaultValue: null)
  final ScalingMode scalingMode;

  Map<String, dynamic> toJson() => _$StyleConfigToJson(this);

  @override
  List<Object?> get props => [
        isUiEnabled,
        playerUiCss,
        playerUiJs,
        supplementalPlayerUiCss,
        isHideFirstFrame,
        scalingMode,
      ];
}
