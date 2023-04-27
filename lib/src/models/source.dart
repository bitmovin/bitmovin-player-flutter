import 'package:bitmovin_sdk/src/configs/source_config.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source.g.dart';

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

  @JsonKey(name: 'sourceConfig', defaultValue: null)
  final SourceConfig? sourceConfig;

  @override
  List<Object?> get props => [id, sourceConfig];

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}
