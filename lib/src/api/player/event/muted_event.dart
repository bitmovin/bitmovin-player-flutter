import 'package:bitmovin_sdk/src/api/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'muted_event.g.dart';

@JsonSerializable(explicitToJson: true)
class MutedEvent extends Event with EquatableMixin {
  const MutedEvent({required super.timestamp});

  factory MutedEvent.fromJson(Map<String, dynamic> json) {
    return _$MutedEventFromJson(json);
  }

  @override
  List<Object?> get props => [timestamp];

  @override
  Map<String, dynamic> toJson() => _$MutedEventToJson(this);
}
