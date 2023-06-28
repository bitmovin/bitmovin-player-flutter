import 'package:bitmovin_player/src/api/licensing_config.dart';
import 'package:bitmovin_player/src/api/playback_config.dart';
import 'package:bitmovin_player/src/api/style_config.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'player_config.g.dart';

@JsonSerializable(explicitToJson: true)
class PlayerConfig extends Equatable {
  const PlayerConfig({
    this.key,
    this.styleConfig = const StyleConfig(),
    this.playbackConfig = const PlaybackConfig(),
    this.licensingConfig = const LicensingConfig(delay: 0),
  });

  factory PlayerConfig.fromJson(Map<String, dynamic> json) {
    return _$PlayerConfigFromJson(json);
  }

  @JsonKey(name: 'key')
  final String? key;

  @JsonKey(name: 'styleConfig')
  final StyleConfig? styleConfig;

  @JsonKey(name: 'playbackConfig')
  final PlaybackConfig? playbackConfig;

  @JsonKey(name: 'licensingConfig')
  final LicensingConfig? licensingConfig;

  Map<String, dynamic> toJson() => _$PlayerConfigToJson(this);

  @override
  List<Object?> get props => [
        key,
        styleConfig,
        playbackConfig,
        licensingConfig,
      ];
}
