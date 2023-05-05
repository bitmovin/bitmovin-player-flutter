import 'package:json_annotation/json_annotation.dart';

enum MediaFilter {
  @JsonValue('None')
  none,
  @JsonValue('Loose')
  loose,
  @JsonValue('Strict')
  strict,
}

extension MediaFilterExtension on MediaFilter {
  static const names = {
    MediaFilter.none: 'None',
    MediaFilter.loose: 'Loose',
    MediaFilter.strict: 'Strict',
  };

  String? get name => names[this];
}
