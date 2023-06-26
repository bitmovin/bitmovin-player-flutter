import 'package:bitmovin_player/src/api/event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source_info_event.g.dart';

@JsonSerializable(explicitToJson: true)
class SourceInfoEvent extends Event with EquatableMixin {
  SourceInfoEvent({this.message, super.timestamp});
  factory SourceInfoEvent.fromJson(Map<String, dynamic> json) {
    return _$SourceInfoEventFromJson(json);
  }

  @override
  List<Object?> get props => [message, timestamp];

  @override
  Map<String, dynamic> toJson() => _$SourceInfoEventToJson(this);

  @JsonKey(name: 'message', defaultValue: null)
  final String? message;
}
