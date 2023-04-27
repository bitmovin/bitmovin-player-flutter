import 'package:bitmovin_sdk/src/models/events/event.dart';
import 'package:bitmovin_sdk/src/models/seek_position.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seek_event.g.dart';

@JsonSerializable(explicitToJson: true)
class SeekEvent extends Event with EquatableMixin {
  const SeekEvent({
    required this.from,
    required this.to,
    required super.timestamp,
  });
  factory SeekEvent.fromJson(Map<String, dynamic> json) {
    return _$SeekEventFromJson(json);
  }

  @JsonKey(name: 'from')
  final SeekPosition from;

  @JsonKey(name: 'to')
  final SeekPosition to;

  @override
  List<Object?> get props => [from, to, timestamp];

  @override
  Map<String, dynamic> toJson() => _$SeekEventToJson(this);
}
