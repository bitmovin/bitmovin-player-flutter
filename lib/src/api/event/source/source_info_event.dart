import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source_info_event.g.dart';

/// Emitted for neutral information provided by the source.
/// The information provided with this event is only for analytical purposes and
/// are subject to change. Thus, neither the timing nor the content should be
/// used to trigger workflows, but may be used for logging.
@JsonSerializable(explicitToJson: true)
class SourceInfoEvent extends InfoEvent with EquatableMixin {
  SourceInfoEvent({required super.timestamp, super.message});

  factory SourceInfoEvent.fromJson(Map<String, dynamic> json) {
    return _$SourceInfoEventFromJson(json);
  }

  @override
  List<Object?> get props => [message, timestamp];

  @override
  Map<String, dynamic> toJson() => _$SourceInfoEventToJson(this);
}
