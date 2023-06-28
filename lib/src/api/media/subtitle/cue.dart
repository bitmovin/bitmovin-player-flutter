import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cue.g.dart';

/// Describes a subtitle cue.
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

  /// The start time of the cue in seconds.
  @JsonKey(name: 'start', required: true, defaultValue: 0.0)
  final double start;

  /// The end time of the cue in seconds.
  @JsonKey(name: 'end', required: true, defaultValue: 0.0)
  final double end;

  /// The cue text.
  @JsonKey(name: 'text', defaultValue: null)
  final String? text;

  /// The cue text as HTML.
  @JsonKey(name: 'html', defaultValue: null)
  final String? html;

  /// The alignment of the cue text.
  @JsonKey(name: 'textAlignment', defaultValue: null)
  final Alignment? textAlignment;

  /// The vertical position of the cue box.
  @JsonKey(name: 'line', required: true, defaultValue: 0.0)
  final double line;

  /// The type of the value from [line].
  @JsonKey(name: 'lineType', required: true, defaultValue: LineType.typeUnset)
  final LineType? lineType;

  /// The cues anchor positioned by [line].
  ///
  /// For the normal case of horizontal text, [AnchorType.anchorTypeStart],
  /// [AnchorType.anchorTypeMiddle] and [AnchorType.anchorTypeEnd] correspond to
  /// the top, middle and bottom of the cue box respectively.
  @JsonKey(
    name: 'lineAnchor',
    required: true,
    defaultValue: AnchorType.typeUnset,
  )
  final AnchorType? lineAnchor;

  /// The fractional position of the [positionAnchor] of the cue within the
  /// viewport in the orthogonal direction to [line].
  ///
  /// For horizontal text, this is the horizontal position relative to the left
  /// of the viewport. Note that positioning is relative to the left of the
  /// viewport even in the case of right-to-left text.
  @JsonKey(
    name: 'fractionalPosition',
    required: true,
    defaultValue: 0.0,
  )
  final double fractionalPosition;

  /// The cue anchor positioned by [fractionalPosition].
  @JsonKey(
    name: 'positionAnchor',
    required: true,
    defaultValue: AnchorType.typeUnset,
  )
  final AnchorType? positionAnchor;

  /// The size of the cue in the writing direction specified as a fraction of
  /// the viewport size in that direction.
  @JsonKey(
    name: 'size',
    required: true,
    defaultValue: 0.0,
  )
  final double? size;

  /// The bitmap height as a fraction of the of the viewport size.
  @JsonKey(
    name: 'bitmapHeight',
    required: true,
    defaultValue: 0.0,
  )
  final double bitmapHeight;

  /// True iff the [windowColor] property is set.
  @JsonKey(
    name: 'isWindowColorSet',
    required: true,
    defaultValue: false,
  )
  final bool isWindowColorSet;

  /// The fill color of the window.
  @JsonKey(
    name: 'windowColor',
    required: true,
    defaultValue: 0,
  )
  final int windowColor;

  /// The cue vertical type.
  /// For the case of horizontal text, [VerticalType.typeUnset] will be set.
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

/// Describes text alignment.
enum Alignment {
  @JsonValue('ALIGN_CENTER')
  center,
  @JsonValue('ALIGN_NORMAL')
  normal,
  @JsonValue('ALIGN_OPPOSITE')
  opposite,
}

/// Represents the vertical formatting for the cue.
enum VerticalType {
  /// Unset vertical type.
  @JsonValue('TypeUnset')
  typeUnset,

  /// Vertical left-to-right.
  @JsonValue('VerticalTypeLeftToRight')
  verticalTypeLeftToRight,

  /// Vertical right-to-left.
  @JsonValue('VerticalTypeRightToLeft')
  verticalTypeRightToLeft,
}

/// @nodoc
extension VerticalTypeExtension on VerticalType {
  static const names = {
    VerticalType.typeUnset: 'TypeUnset',
    VerticalType.verticalTypeLeftToRight: 'VerticalTypeLeftToRight',
    VerticalType.verticalTypeRightToLeft: 'VerticalTypeRightToLeft',
  };

  String? get name => names[this];
}

/// Represents the available line types for the cue.
enum LineType {
  /// Unset line type.
  @JsonValue('TypeUnset')
  typeUnset,

  /// Value for [Cue.lineType] when [Cue.line] is a fractional position.
  @JsonValue('LineTypeFraction')
  lineTypeFraction,

  /// Value for [Cue.lineType] when [Cue.line] is a line number.
  @JsonValue('LineTypeNumber')
  lineTypeNumber,
}

/// @nodoc
extension LineTypeExtension on LineType {
  static const names = {
    LineType.typeUnset: 'TypeUnset',
    LineType.lineTypeFraction: 'LineTypeFraction',
    LineType.lineTypeNumber: 'LineTypeNumber',
  };

  String? get name => names[this];
}

/// Represents the available anchor types for the cue.
enum AnchorType {
  /// Unset anchor type.
  @JsonValue('TypeUnset')
  typeUnset,

  /// Anchors the left (for horizontal positions) or top (for vertical
  /// positions) edge of the cue.
  @JsonValue('AnchorTypeStart')
  anchorTypeStart,

  /// Anchors the middle of the cue.
  @JsonValue('AnchorTypeMiddle')
  anchorTypeMiddle,

  /// Anchors the right (for horizontal positions) or bottom (for vertical
  /// positions) edge of the cue.
  @JsonValue('AnchorTypeEnd')
  anchorTypeEnd,
}

/// @nodoc
extension AnchorTypeExtension on AnchorType {
  static const names = {
    AnchorType.typeUnset: 'TypeUnset',
    AnchorType.anchorTypeStart: 'AnchorTypeStart',
    AnchorType.anchorTypeMiddle: 'AnchorTypeMiddle',
    AnchorType.anchorTypeEnd: 'AnchorTypeEnd',
  };

  String? get name => names[this];
}
