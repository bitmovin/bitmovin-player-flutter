import 'package:bitmovin_sdk/src/api/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source_error_event.g.dart';

@JsonSerializable(explicitToJson: true)
class SourceErrorEvent extends Event with EquatableMixin {
  const SourceErrorEvent({
    this.code,
    this.data,
    this.message,
    super.timestamp,
  });

  factory SourceErrorEvent.fromJson(Map<String, dynamic> json) {
    return _$SourceErrorEventFromJson(json);
  }

  @override
  List<Object?> get props => [
        code,
        data,
        message,
        timestamp,
      ];

  @JsonKey(name: 'code', defaultValue: null)
  final num? code;

  @JsonKey(name: 'data', defaultValue: null)
  final dynamic data;

  @JsonKey(name: 'message', defaultValue: null)
  final String? message;

  @override
  Map<String, dynamic> toJson() => _$SourceErrorEventToJson(this);
}
