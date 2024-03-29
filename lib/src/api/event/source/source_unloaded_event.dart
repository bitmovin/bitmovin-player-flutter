import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source_unloaded_event.g.dart';

/// Emitted when a [Source] was unloaded.
@JsonSerializable(explicitToJson: true)
class SourceUnloadedEvent extends Event with EquatableMixin {
  const SourceUnloadedEvent({required super.timestamp});

  factory SourceUnloadedEvent.fromJson(Map<String, dynamic> json) {
    return _$SourceUnloadedEventFromJson(json);
  }

  @override
  List<Object?> get props => [timestamp];

  @override
  Map<String, dynamic> toJson() => _$SourceUnloadedEventToJson(this);
}
