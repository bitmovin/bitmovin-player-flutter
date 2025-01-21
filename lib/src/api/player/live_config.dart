import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'live_config.g.dart';

/// Configures the behavior when playing live content.
@JsonSerializable(explicitToJson: true)
class LiveConfig extends Equatable {
  const LiveConfig({
    this.minTimeShiftBufferDepth = -40.0,
    this.liveEdgeOffset = -1.0,
  });

  factory LiveConfig.fromJson(Map<String, dynamic> json) {
    return _$LiveConfigFromJson(json);
  }

  /// The minimum buffer depth of a stream needed to enable time shifting. If
  /// the available buffer depth is shorter, time shifting is disabled and
  /// [Player.maxTimeShift] returns 0.
  /// Default value is -40.0.
  @JsonKey(name: 'minTimeShiftBufferDepth')
  final double minTimeShiftBufferDepth;

  /// The duration in seconds by which the default start position should precede
  /// the end of the live window. A suggested presentation delay in a manifest
  /// will be overridden. In case of a DASH low latency stream, the
  /// [liveEdgeOffset] will be ignored. A value lower than 0 disables this
  /// feature.
  /// Has no effect with HLS and Progressive sources.
  /// Default value is -1.0.
  @JsonKey(name: 'liveEdgeOffset')
  final double liveEdgeOffset;

  Map<String, dynamic> toJson() => _$LiveConfigToJson(this);

  @override
  List<Object?> get props => [
        minTimeShiftBufferDepth,
        liveEdgeOffset,
      ];
}
