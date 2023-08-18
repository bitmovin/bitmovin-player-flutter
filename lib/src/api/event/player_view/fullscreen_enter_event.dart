import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fullscreen_enter_event.g.dart';

/// Emitted when the [PlayerView] goes into fullscreen mode.
@JsonSerializable(explicitToJson: true)
class FullscreenEnterEvent extends Event with EquatableMixin {
  const FullscreenEnterEvent({
    required super.timestamp,
  });

  factory FullscreenEnterEvent.fromJson(Map<String, dynamic> json) {
    return _$FullscreenEnterEventFromJson(json);
  }

  @override
  List<Object?> get props => [timestamp];

  @override
  Map<String, dynamic> toJson() => _$FullscreenEnterEventToJson(this);
}
