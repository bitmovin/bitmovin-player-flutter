import 'package:json_annotation/json_annotation.dart';

enum SeekMode {
  @JsonValue('Exact')
  exact,
  @JsonValue('ClosestSync')
  closesSync,
  @JsonValue('PreviousSync')
  previousSync,
  @JsonValue('NextSync')
  nextSync,
}

extension SeekModeExtension on SeekMode {
  static const names = {
    SeekMode.exact: 'Exact',
    SeekMode.closesSync: 'ClosestSync',
    SeekMode.previousSync: 'PreviousSync',
    SeekMode.nextSync: 'NextSync',
  };

  String? get name => names[this];
}
