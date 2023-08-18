import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fullscreen_exit_event.g.dart';

/// Emitted when the [PlayerView] leaves fullscreen mode.
@JsonSerializable(explicitToJson: true)
class FullscreenExitEvent extends Event with EquatableMixin {
  const FullscreenExitEvent({
    required super.timestamp,
  });

  factory FullscreenExitEvent.fromJson(Map<String, dynamic> json) {
    return _$FullscreenExitEventFromJson(json);
  }

  @override
  List<Object?> get props => [timestamp];

  @override
  Map<String, dynamic> toJson() => _$FullscreenExitEventToJson(this);
}
