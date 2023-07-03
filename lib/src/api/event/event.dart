import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

/// The common supertype implemented by all different player and source events.
@JsonSerializable(explicitToJson: true)
class Event extends Equatable {
  const Event({required this.timestamp});
  factory Event.fromJson(Map<String, dynamic> json) {
    return _$EventFromJson(json);
  }
  @JsonKey(name: 'timestamp')
  final int? timestamp;

  @override
  List<Object?> get props => [timestamp];

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
