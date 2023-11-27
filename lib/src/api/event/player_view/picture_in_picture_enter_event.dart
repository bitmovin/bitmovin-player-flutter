import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'picture_in_picture_enter_event.g.dart';

/// Is called when the [PlayerView] is about to enter Picture in Picture mode.
@JsonSerializable(explicitToJson: true)
class PictureInPictureEnterEvent extends Event with EquatableMixin {
  const PictureInPictureEnterEvent({required super.timestamp});

  factory PictureInPictureEnterEvent.fromJson(Map<String, dynamic> json) {
    return _$PictureInPictureEnterEventFromJson(json);
  }

  @override
  List<Object?> get props => [timestamp];

  @override
  Map<String, dynamic> toJson() => _$PictureInPictureEnterEventToJson(this);
}
