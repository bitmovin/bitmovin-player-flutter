import 'package:bitmovin_player/src/api/event.dart';
import 'package:bitmovin_player/src/api/source/source.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source_added_event.g.dart';

@JsonSerializable(explicitToJson: true)
class SourceAddedEvent extends Event with EquatableMixin {
  const SourceAddedEvent({
    required this.source,
    required super.timestamp,
    required this.index,
  });
  factory SourceAddedEvent.fromJson(Map<String, dynamic> json) {
    return _$SourceAddedEventFromJson(json);
  }

  @JsonKey(name: 'source')
  final Source source;

  @JsonKey(name: 'index')
  final int index;

  @override
  List<Object?> get props => [source, index, timestamp];

  @override
  Map<String, dynamic> toJson() => _$SourceAddedEventToJson(this);
}
