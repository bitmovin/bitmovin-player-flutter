import 'package:bitmovin_sdk/src/models/events/event.dart';
import 'package:bitmovin_sdk/src/models/source.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'load_event.g.dart';

@JsonSerializable(explicitToJson: true)
class LoadEvent extends Event with EquatableMixin {
  LoadEvent({
    required this.source,
    required super.timestamp,
  });

  factory LoadEvent.fromJson(Map<String, dynamic> json) {
    return _$LoadEventFromJson(json);
  }

  @JsonKey(name: 'source')
  final Source source;

  @override
  List<Object?> get props => [source, timestamp];

  @override
  Map<String, dynamic> toJson() => _$LoadEventToJson(this);
}
