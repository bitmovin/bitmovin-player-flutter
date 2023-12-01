import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'picture_in_picture_exited_event.g.dart';

/// Is called when the [PlayerView] finished exiting Picture-In-Picture mode.
///
/// Only available on iOS.
@JsonSerializable(explicitToJson: true)
class PictureInPictureExitedEvent extends Event with EquatableMixin {
  const PictureInPictureExitedEvent({required super.timestamp});

  factory PictureInPictureExitedEvent.fromJson(Map<String, dynamic> json) {
    return _$PictureInPictureExitedEventFromJson(json);
  }

  @override
  List<Object?> get props => [timestamp];

  @override
  Map<String, dynamic> toJson() => _$PictureInPictureExitedEventToJson(this);
}
