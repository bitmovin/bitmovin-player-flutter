import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
// import 'package:bitmap/bitmap.dart';

part 'cue.g.dart';

@JsonSerializable(explicitToJson: true)
class Cue extends Equatable {
  const Cue({
    required this.start,
    required this.end,
    required this.line,
    required this.fractionalPosition,
    required this.bitmapHeight,
    required this.isWindowColorSet,
    required this.windowColor,
    this.text,
    this.html,
    this.textAlignment,
    this.lineType,
    this.lineAnchor,
    this.positionAnchor,
    this.size,
    this.verticalType,
  });
  factory Cue.fromJson(Map<String, dynamic> json) {
    return _$CueFromJson(json);
  }

  @JsonKey(name: 'start', required: true, defaultValue: 0.0)
  final double start;

  @JsonKey(name: 'end', required: true, defaultValue: 0.0)
  final double end;

  @JsonKey(name: 'text', defaultValue: null)
  final String? text;

  @JsonKey(name: 'html', defaultValue: null)
  final String? html;

  @JsonKey(name: 'textAlignment', defaultValue: null)
  final Alignment? textAlignment;

  @JsonKey(name: 'line', required: true, defaultValue: 0.0)
  final double line;

  @JsonKey(name: 'lineType', required: true, defaultValue: LineType.typeUnset)
  final LineType? lineType;

  @JsonKey(
    name: 'lineAnchor',
    required: true,
    defaultValue: AnchorType.typeUnset,
  )
  final AnchorType? lineAnchor;

  @JsonKey(
    name: 'fractionalPosition',
    required: true,
    defaultValue: 0.0,
  )
  final double fractionalPosition;

  @JsonKey(
    name: 'positionAnchor',
    required: true,
    defaultValue: AnchorType.typeUnset,
  )
  final AnchorType? positionAnchor;

  @JsonKey(
    name: 'size',
    required: true,
    defaultValue: 0.0,
  )
  final double? size;

  @JsonKey(
    name: 'bitmapHeight',
    required: true,
    defaultValue: 0.0,
  )
  final double bitmapHeight;

  @JsonKey(
    name: 'isWindowColorSet',
    required: true,
    defaultValue: false,
  )
  final bool isWindowColorSet;

  @JsonKey(
    name: 'windowColor',
    required: true,
    defaultValue: 0,
  )
  final int windowColor;

  @JsonKey(
    name: 'verticalType',
    required: true,
    defaultValue: VerticalType.typeUnset,
  )
  final VerticalType? verticalType;

  @override
  List<Object?> get props => [];

  Map<String, dynamic> toJson() => _$CueToJson(this);
}

enum Alignment {
  @JsonValue('ALIGN_CENTER')
  center,
  @JsonValue('ALIGN_NORMAL')
  normal,
  @JsonValue('ALIGN_OPPOSITE')
  opposite,
}

enum VerticalType {
  @JsonValue('TypeUnset')
  typeUnset,
  @JsonValue('VerticalTypeLeftToRight')
  verticalTypeLeftToRight,
  @JsonValue('VerticalTypeRightToLeft')
  verticalTypeRightToLeft,
}

extension VerticalTypeExtension on VerticalType {
  static const names = {
    VerticalType.typeUnset: 'TypeUnset',
    VerticalType.verticalTypeLeftToRight: 'VerticalTypeLeftToRight',
    VerticalType.verticalTypeRightToLeft: 'VerticalTypeRightToLeft',
  };

  String? get name => names[this];
}

enum LineType {
  @JsonValue('TypeUnset')
  typeUnset,
  @JsonValue('LineTypeFraction')
  lineTypeFraction,
  @JsonValue('LineTypeNumber')
  lineTypeNumber,
}

extension LineTypeExtension on LineType {
  static const names = {
    LineType.typeUnset: 'TypeUnset',
    LineType.lineTypeFraction: 'LineTypeFraction',
    LineType.lineTypeNumber: 'LineTypeNumber',
  };

  String? get name => names[this];
}

enum AnchorType {
  @JsonValue('TypeUnset')
  typeUnset,
  @JsonValue('AnchorTypeStart')
  anchorTypeStart,
  @JsonValue('AnchorTypeMiddle')
  anchorTypeMiddle,
  @JsonValue('AnchorTypeEnd')
  anchorTypeEnd,
}

extension AnchorTypeExtension on AnchorType {
  static const names = {
    AnchorType.typeUnset: 'TypeUnset',
    AnchorType.anchorTypeStart: 'AnchorTypeStart',
    AnchorType.anchorTypeMiddle: 'AnchorTypeMiddle',
    AnchorType.anchorTypeEnd: 'AnchorTypeEnd',
  };

  String? get name => names[this];
}
