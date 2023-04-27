import 'package:bitmovin_sdk/src/models/events/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unmuted_event.g.dart';

@JsonSerializable(explicitToJson: true)
class UnMutedEvent extends Event with EquatableMixin {
  const UnMutedEvent({required super.timestamp});

  factory UnMutedEvent.fromJson(Map<String, dynamic> json) {
    return _$UnMutedEventFromJson(json);
  }

  @override
  List<Object?> get props => [timestamp];

  @override
  Map<String, dynamic> toJson() => _$UnMutedEventToJson(this);
}
