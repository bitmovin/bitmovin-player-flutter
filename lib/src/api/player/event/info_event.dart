import 'package:bitmovin_sdk/src/api/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'info_event.g.dart';

@JsonSerializable(explicitToJson: true)
class InfoEvent extends Event with EquatableMixin {
  const InfoEvent({
    required super.timestamp,
    this.message,
  });
  factory InfoEvent.fromJson(Map<String, dynamic> json) {
    return _$InfoEventFromJson(json);
  }

  @JsonKey(name: 'message', defaultValue: null)
  final String? message;

  @override
  List<Object?> get props => [message, timestamp];

  @override
  Map<String, dynamic> toJson() => _$InfoEventToJson(this);
}
