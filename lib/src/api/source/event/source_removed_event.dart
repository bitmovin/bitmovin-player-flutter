import 'package:bitmovin_player/src/api/event.dart';
import 'package:bitmovin_player/src/api/source/source.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source_removed_event.g.dart';

@JsonSerializable(explicitToJson: true)
class SourceRemovedEvent extends Event with EquatableMixin {
  const SourceRemovedEvent({
    required this.source,
    required super.timestamp,
    required this.index,
  });
  factory SourceRemovedEvent.fromJson(Map<String, dynamic> json) {
    return _$SourceRemovedEventFromJson(json);
  }

  @JsonKey(name: 'source')
  final Source source;

  @JsonKey(name: 'index')
  final int index;

  @override
  List<Object?> get props => [source, index, timestamp];

  @override
  Map<String, dynamic> toJson() => _$SourceRemovedEventToJson(this);
}
