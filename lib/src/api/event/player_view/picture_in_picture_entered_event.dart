import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:json_annotation/json_annotation.dart';

part 'picture_in_picture_entered_event.g.dart';

/// Is called when the [PlayerView] finished entering Picture-In-Picture mode.
///
/// Only available on iOS.
@JsonSerializable(explicitToJson: true)
class PictureInPictureEnteredEvent extends Event {
  const PictureInPictureEnteredEvent({required super.timestamp});

  factory PictureInPictureEnteredEvent.fromJson(Map<String, dynamic> json) {
    return _$PictureInPictureEnteredEventFromJson(json);
  }

  @override
  List<Object?> get props => [timestamp];

  @override
  Map<String, dynamic> toJson() => _$PictureInPictureEnteredEventToJson(this);
}
