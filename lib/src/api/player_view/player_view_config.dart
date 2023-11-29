import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'player_view_config.g.dart';

/// Configures a new [PlayerView] instance.
@JsonSerializable(explicitToJson: true)
class PlayerViewConfig extends Equatable {
  const PlayerViewConfig({
    this.pictureInPictureConfig = const PictureInPictureConfig(),
  });

  factory PlayerViewConfig.fromJson(Map<String, dynamic> json) {
    return _$PlayerViewConfigFromJson(json);
  }

  /// Configures Picture-in-Picture playback.
  /// A default [PictureInPictureConfig] is set initially
  final PictureInPictureConfig pictureInPictureConfig;

  @override
  List<Object?> get props => [pictureInPictureConfig];

  Map<String, dynamic> toJson() => _$PlayerViewConfigToJson(this);
}
