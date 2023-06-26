import 'package:bitmovin_player/src/api/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source_unloaded_event.g.dart';

@JsonSerializable(explicitToJson: true)
class SourceUnloadedEvent extends Event with EquatableMixin {
  const SourceUnloadedEvent({required super.timestamp});

  factory SourceUnloadedEvent.fromJson(Map<String, dynamic> json) {
    return _$SourceUnloadedEventFromJson(json);
  }

  @override
  List<Object?> get props => [timestamp];

  @override
  Map<String, dynamic> toJson() => _$SourceUnloadedEventToJson(this);
}
