import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
// import 'package:bitmap/bitmap.dart';

part 'cue.g.dart';

@JsonSerializable(explicitToJson: true)
class Cue extends Equatable {
  const Cue();

  @override
  List<Object?> get props => [];
  // Cue({
  //   this.start,
  //   this.end,
  //   this.text,
  //   this.html,
  //   this.bitmap,
  //   this.textAlignment,
  //   this.line,
  //   this.lineType,
  //   this.lineAnchor,
  //   this.fractionalPosition,
  //   this.positionAnchor,
  //   this.size,
  //   this.bitmapHeight,
  //   this.isWindowColorSet,
  //   this.windowColor,
  //   this.verticalType,
  // });

  // final double start;
  // final double end;
  // final String? text;
  // final String? html;
  // final Bitmap? bitmap;
  // final Alignment? textAlignment;
  // final double line;
  // final LineType lineType;
  // final AnchorType lineAnchor;
  // final double fractionalPosition;
  // final AnchorType positionAnchor;
  // final double size;
  // final double bitmapHeight;
  // final bool isWindowColorSet;
  // final int windowColor;
  // final VerticalType verticalType;

  factory Cue.fromJson(Map<String, dynamic> json) {
    return _$CueFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CueToJson(this);
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
