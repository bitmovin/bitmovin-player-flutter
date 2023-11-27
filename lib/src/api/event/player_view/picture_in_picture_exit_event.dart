import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'picture_in_picture_exit_event.g.dart';

/// Is called when the [PlayerView] is about to exit Picture in Picture mode.
@JsonSerializable(explicitToJson: true)
class PictureInPictureExitEvent extends Event with EquatableMixin {
  const PictureInPictureExitEvent({required super.timestamp});

  factory PictureInPictureExitEvent.fromJson(Map<String, dynamic> json) {
    return _$PictureInPictureExitEventFromJson(json);
  }

  @override
  List<Object?> get props => [timestamp];

  @override
  Map<String, dynamic> toJson() => _$PictureInPictureExitEventToJson(this);
}
