import 'package:bitmovin_sdk/src/api/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unmuted_event.g.dart';

@JsonSerializable(explicitToJson: true)
class UnmutedEvent extends Event with EquatableMixin {
  const UnmutedEvent({required super.timestamp});

  factory UnmutedEvent.fromJson(Map<String, dynamic> json) {
    return _$UnmutedEventFromJson(json);
  }

  @override
  List<Object?> get props => [timestamp];

  @override
  Map<String, dynamic> toJson() => _$UnmutedEventToJson(this);
}
