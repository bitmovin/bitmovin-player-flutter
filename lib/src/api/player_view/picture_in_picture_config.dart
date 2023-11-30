import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'picture_in_picture_config.g.dart';

/// Provides options to configure Picture-in-Picture playback.
@JsonSerializable(explicitToJson: true)
class PictureInPictureConfig extends Equatable {
  const PictureInPictureConfig({
    this.isEnabled = false,
    this.shouldEnterOnBackground = false,
  });

  factory PictureInPictureConfig.fromJson(Map<String, dynamic> json) {
    return _$PictureInPictureConfigFromJson(json);
  }

  /// Whether Picture in Picture feature is enabled or not. Default is `false`.
  final bool isEnabled;

  /// Defines whether Picture in Picture should start automatically when the app
  /// transitions to background.
  ///
  /// Does not have any affect when Picture in Picture is disabled.
  ///
  /// Default is `false`.
  final bool shouldEnterOnBackground;

  @override
  List<Object?> get props => [isEnabled, shouldEnterOnBackground];

  Map<String, dynamic> toJson() => _$PictureInPictureConfigToJson(this);
}
