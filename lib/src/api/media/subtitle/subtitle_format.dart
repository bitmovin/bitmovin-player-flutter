import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:json_annotation/json_annotation.dart';

/// The subtitle file format used by a [SubtitleTrack].
enum SubtitleFormat {
  @JsonValue('Vtt')
  vtt,

  @JsonValue('Ttml')
  ttml,

  @JsonValue('Cea')
  cea,
}
