import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source.g.dart';

/// Represents audio and video content that can be loaded into a [Player]
/// to start a playback session.
@JsonSerializable(explicitToJson: true)
class Source extends Equatable {
  const Source({
    required this.sourceConfig,
    this.id,
    this.remoteControl,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('config') && json.containsKey('id')) {
      json['sourceConfig'] = json['config'];
      return _$SourceFromJson(json);
    }
    return _$SourceFromJson(json);
  }

  @JsonKey(name: 'id')
  final String? id;

  /// Configuration that will be used by this [Source]
  @JsonKey(name: 'sourceConfig', required: true)
  final SourceConfig sourceConfig;

  /// The remote control config for this source.
  /// Only supported on iOS.
  final SourceRemoteControlConfig? remoteControl;

  @override
  List<Object?> get props => [id, sourceConfig, remoteControl];

  /// Converts this [Source] into a JSON friendly [Map].
  Map<String, dynamic> toJson() => _$SourceToJson(this);
}
