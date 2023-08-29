import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'player_config.g.dart';

/// Configures a new [Player] instance.
/// Must not be modified after it was used to create a [Player] instance.
@JsonSerializable(explicitToJson: true)
class PlayerConfig extends Equatable {
  const PlayerConfig({
    this.key,
    this.styleConfig = const StyleConfig(),
    this.playbackConfig = const PlaybackConfig(),
    this.licensingConfig = const LicensingConfig(),
    this.liveConfig = const LiveConfig(),
    this.analyticsConfig,
  });

  factory PlayerConfig.fromJson(Map<String, dynamic> json) {
    return _$PlayerConfigFromJson(json);
  }

  /// A Bitmovin player license key that can be found in the Bitmovin dashboard.
  @JsonKey(name: 'key')
  final String? key;

  /// Configures visual presentation and behavior of the Player UI.
  /// A default [StyleConfig] is used if not set here.
  @JsonKey(name: 'styleConfig')
  final StyleConfig? styleConfig;

  /// Configures playback behavior.
  /// A default [PlaybackConfig] is used if not set here.
  @JsonKey(name: 'playbackConfig')
  final PlaybackConfig? playbackConfig;

  /// Configures license evaluation.
  /// A default [LicensingConfig] is used if not set here.
  @JsonKey(name: 'licensingConfig')
  final LicensingConfig? licensingConfig;

  /// Configures behavior when playing live content.
  /// A default [LiveConfig] is set initially
  @JsonKey(name: 'liveConfig')
  final LiveConfig liveConfig;

  /// Configuration for the Bitmovin Analytics Collector.
  @JsonKey(name: 'analyticsConfig')
  final AnalyticsConfig? analyticsConfig;

  Map<String, dynamic> toJson() => _$PlayerConfigToJson(this);

  @override
  List<Object?> get props => [
        key,
        styleConfig,
        playbackConfig,
        licensingConfig,
        liveConfig,
      ];
}
