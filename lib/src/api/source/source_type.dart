import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:json_annotation/json_annotation.dart';

/// Available stream types for a [Source].
enum SourceType {
  /// For DASH streams.
  @JsonValue('dash')
  dash,

  /// For HLS streams.
  @JsonValue('hls')
  hls,

  /// For progressive assets.
  @JsonValue('progressive')
  progressive,
}

/// @nodoc
extension SourceTypeExtension on SourceType {
  static const Map<SourceType, String> names = {
    SourceType.dash: 'dash',
    SourceType.hls: 'hls',
    SourceType.progressive: 'progressive',
  };

  String? get name => names[this];
}
