import 'package:bitmovin_player/src/api/event/event.dart';
import 'package:bitmovin_player/src/source.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source_load_event.g.dart';

/// Emitted when a [Source] starts loading.
@JsonSerializable(explicitToJson: true)
class SourceLoadEvent extends Event with EquatableMixin {
  SourceLoadEvent({
    required this.source,
    required super.timestamp,
  });

  factory SourceLoadEvent.fromJson(Map<String, dynamic> json) {
    return _$SourceLoadEventFromJson(json);
  }

  /// The [Source] that started loading.
  @JsonKey(name: 'source')
  final Source source;

  @override
  List<Object?> get props => [source, timestamp];

  @override
  Map<String, dynamic> toJson() => _$SourceLoadEventToJson(this);
}
