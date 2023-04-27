import 'package:bitmovin_sdk/src/models/events/event.dart';
import 'package:bitmovin_sdk/src/models/source.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'loaded_event.g.dart';

@JsonSerializable(explicitToJson: true)
class LoadedEvent extends Event with EquatableMixin {
  const LoadedEvent({
    required this.source,
    required super.timestamp,
  });

  factory LoadedEvent.fromJson(Map<String, dynamic> json) {
    return _$LoadedEventFromJson(json);
  }

  @JsonKey(name: 'source')
  final Source source;

  @override
  List<Object?> get props => [source, timestamp];

  @override
  Map<String, dynamic> toJson() => _$LoadedEventToJson(this);
}
