import 'package:bitmovin_sdk/src/api/event.dart';
import 'package:bitmovin_sdk/src/api/source/source.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source_loaded_event.g.dart';

@JsonSerializable(explicitToJson: true)
class SourceLoadedEvent extends Event with EquatableMixin {
  const SourceLoadedEvent({
    required this.source,
    required super.timestamp,
  });

  factory SourceLoadedEvent.fromJson(Map<String, dynamic> json) {
    return _$SourceLoadedEventFromJson(json);
  }

  @JsonKey(name: 'source')
  final Source source;

  @override
  List<Object?> get props => [source, timestamp];

  @override
  Map<String, dynamic> toJson() => _$SourceLoadedEventToJson(this);
}
