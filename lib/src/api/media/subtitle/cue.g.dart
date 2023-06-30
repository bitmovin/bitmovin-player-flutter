// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cue _$CueFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['start', 'end'],
  );
  return Cue(
    start: (json['start'] as num).toDouble(),
    end: (json['end'] as num).toDouble(),
    line: (json['line'] as num?)?.toDouble(),
    fractionalPosition: (json['fractionalPosition'] as num?)?.toDouble(),
    bitmapHeight: (json['bitmapHeight'] as num?)?.toDouble(),
    isWindowColorSet: json['isWindowColorSet'] as bool? ?? false,
    windowColor: json['windowColor'] as int?,
    text: json['text'] as String?,
    html: json['html'] as String?,
    textAlignment:
        $enumDecodeNullable(_$AlignmentEnumMap, json['textAlignment']),
    lineType: $enumDecodeNullable(_$LineTypeEnumMap, json['lineType']) ??
        LineType.typeUnset,
    lineAnchor: $enumDecodeNullable(_$AnchorTypeEnumMap, json['lineAnchor']) ??
        AnchorType.typeUnset,
    positionAnchor:
        $enumDecodeNullable(_$AnchorTypeEnumMap, json['positionAnchor']) ??
            AnchorType.typeUnset,
    size: (json['size'] as num?)?.toDouble(),
    verticalType:
        $enumDecodeNullable(_$VerticalTypeEnumMap, json['verticalType']) ??
            VerticalType.typeUnset,
  );
}

Map<String, dynamic> _$CueToJson(Cue instance) => <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
      'text': instance.text,
      'html': instance.html,
      'textAlignment': _$AlignmentEnumMap[instance.textAlignment],
      'line': instance.line,
      'lineType': _$LineTypeEnumMap[instance.lineType]!,
      'lineAnchor': _$AnchorTypeEnumMap[instance.lineAnchor]!,
      'fractionalPosition': instance.fractionalPosition,
      'positionAnchor': _$AnchorTypeEnumMap[instance.positionAnchor]!,
      'size': instance.size,
      'bitmapHeight': instance.bitmapHeight,
      'isWindowColorSet': instance.isWindowColorSet,
      'windowColor': instance.windowColor,
      'verticalType': _$VerticalTypeEnumMap[instance.verticalType]!,
    };

const _$AlignmentEnumMap = {
  Alignment.center: 'ALIGN_CENTER',
  Alignment.normal: 'ALIGN_NORMAL',
  Alignment.opposite: 'ALIGN_OPPOSITE',
};

const _$LineTypeEnumMap = {
  LineType.typeUnset: 'TypeUnset',
  LineType.lineTypeFraction: 'LineTypeFraction',
  LineType.lineTypeNumber: 'LineTypeNumber',
};

const _$AnchorTypeEnumMap = {
  AnchorType.typeUnset: 'TypeUnset',
  AnchorType.anchorTypeStart: 'AnchorTypeStart',
  AnchorType.anchorTypeMiddle: 'AnchorTypeMiddle',
  AnchorType.anchorTypeEnd: 'AnchorTypeEnd',
};

const _$VerticalTypeEnumMap = {
  VerticalType.typeUnset: 'TypeUnset',
  VerticalType.verticalTypeLeftToRight: 'VerticalTypeLeftToRight',
  VerticalType.verticalTypeRightToLeft: 'VerticalTypeRightToLeft',
};
