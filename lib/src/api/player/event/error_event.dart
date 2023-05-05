import 'package:bitmovin_sdk/src/api/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error_event.g.dart';

@JsonSerializable(explicitToJson: true)
class ErrorEvent extends Event with EquatableMixin {
  const ErrorEvent({
    this.code,
    this.message,
    this.data,
    required super.timestamp,
  });

  factory ErrorEvent.fromJson(Map<String, dynamic> json) {
    return _$ErrorEventFromJson(json);
  }

  @JsonKey(name: 'code', defaultValue: null)
  final num? code;

  @JsonKey(name: 'data', defaultValue: null)
  final dynamic data;

  @JsonKey(name: 'message', defaultValue: null)
  final String? message;

  @override
  List<Object?> get props => [
        code,
        message,
        data,
        timestamp,
      ];

  @override
  Map<String, dynamic> toJson() => _$ErrorEventToJson(this);
}
