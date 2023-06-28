import 'package:bitmovin_player/src/api/ui/scaling_mode.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'style_config.g.dart';

/// Configures visual presentation and behaviour of the Player UI.
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

  /// Whether the Player UI is enabled.
  /// Default value is `true`.
  @JsonKey(name: 'isUiEnabled', defaultValue: true)
  final bool isUiEnabled;

  /// Optional URI pointing to the CSS file that should be used for the
  /// Player UI instead of the default CSS file.
  @JsonKey(name: 'playerUiCss', defaultValue: null)
  final String? playerUiCss;

  /// Optional URI pointing to the JS file that should be used for the
  /// Player UI instead of the default JS file.
  @JsonKey(name: 'playerUiJs', defaultValue: null)
  final String? playerUiJs;

  /// Optional URI pointing to the supplemental CSS file that will be used for
  /// the Player UI. The contained styles will be added to the CSS file
  /// specified in [playerUiCss].
  @JsonKey(name: 'supplementalPlayerUiCss', defaultValue: null)
  final String? supplementalPlayerUiCss;

  /// Whether the first frame of the main content will be rendered before
  /// playback starts.
  /// Default value is `false`.
  @JsonKey(name: 'isHideFirstFrame', defaultValue: null)
  final bool isHideFirstFrame;

  /// Specifies how the video content is scaled or stretched within the parent
  /// container's bounds.
  /// Default value is [ScalingMode.fit].
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
