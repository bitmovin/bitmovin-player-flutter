import 'package:bitmovin_sdk/src/configs/source_config.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source.g.dart';

@JsonSerializable(explicitToJson: true)
class Source extends Equatable {
  const Source(this.sourceConfig);

  factory Source.fromJson(Map<String, dynamic> json) {
    return _$SourceFromJson(json);
  }

  @JsonKey(name: 'sourceConfig', disallowNullValue: true)
  final SourceConfig sourceConfig;

  @override
  List<Object?> get props => [sourceConfig];

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}
