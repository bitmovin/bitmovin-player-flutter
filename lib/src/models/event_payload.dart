import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_payload.g.dart';

@JsonSerializable(explicitToJson: true)
class EventPayload extends Equatable {
  const EventPayload({
    required this.eventName,
    this.data,
  });
  factory EventPayload.fromJson(Map<String, dynamic> json) {
    return _$EventPayloadFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EventPayloadToJson(this);

  @override
  List<Object?> get props => [eventName, data];

  @JsonKey(name: 'event')
  final String eventName;

  @JsonKey(name: 'data')
  final dynamic data;
}
