import 'package:bitmovin_sdk/src/api/source_config.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source.g.dart';

/// Represents audio and video content that can be loaded into a [Player]
/// to start a playback session.
@JsonSerializable(explicitToJson: true)
class Source extends Equatable {
  const Source({
    this.sourceConfig,
    this.id,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('config') && json.containsKey('id')) {
      json['sourceConfig'] = json['config'];
      return _$SourceFromJson(json);
    }
    return _$SourceFromJson(json);
  }

  @JsonKey(name: 'id', defaultValue: null)
  final String? id;

  /// Configuration that will be used by this [Source]
  @JsonKey(name: 'sourceConfig', defaultValue: null)
  final SourceConfig? sourceConfig;

  @override
  List<Object?> get props => [id, sourceConfig];

  /// Converts this [Source] into a JSON friendly type of Map<String, dynamic>
  ///
  /// returns a Map<String, dynamic> representation.
  Map<String, dynamic> toJson() => _$SourceToJson(this);
}
