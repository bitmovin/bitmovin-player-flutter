import 'package:bitmovin_sdk/src/models/events/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seeked_event.g.dart';

@JsonSerializable(explicitToJson: true)
class SeekedEvent extends Event with EquatableMixin {
  const SeekedEvent({
    required super.timestamp,
  });

  factory SeekedEvent.fromJson(Map<String, dynamic> json) {
    return _$SeekedEventFromJson(json);
  }

  @override
  List<Object?> get props => [timestamp];

  @override
  Map<String, dynamic> toJson() => _$SeekedEventToJson(this);
}
