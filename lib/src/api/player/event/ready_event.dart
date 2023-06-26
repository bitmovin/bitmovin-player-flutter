import 'package:bitmovin_player/src/api/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ready_event.g.dart';

@JsonSerializable(explicitToJson: true)
class ReadyEvent extends Event with EquatableMixin {
  const ReadyEvent({required super.timestamp});

  factory ReadyEvent.fromJson(Map<String, dynamic> json) {
    return _$ReadyEventFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$ReadyEventToJson(this);

  @override
  List<Object?> get props => [timestamp];
}
