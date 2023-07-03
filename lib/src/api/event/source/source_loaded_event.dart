import 'package:bitmovin_player/src/api/event/event.dart';
import 'package:bitmovin_player/src/source.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source_loaded_event.g.dart';

/// Emitted when a [Source] was loaded. This does not mean that the source is
/// immediately ready for playback.
@JsonSerializable(explicitToJson: true)
class SourceLoadedEvent extends Event with EquatableMixin {
  const SourceLoadedEvent({
    required this.source,
    required super.timestamp,
  });

  factory SourceLoadedEvent.fromJson(Map<String, dynamic> json) {
    return _$SourceLoadedEventFromJson(json);
  }

  /// The [Source] that finished loading.
  @JsonKey(name: 'source')
  final Source source;

  @override
  List<Object?> get props => [source, timestamp];

  @override
  Map<String, dynamic> toJson() => _$SourceLoadedEventToJson(this);
}
