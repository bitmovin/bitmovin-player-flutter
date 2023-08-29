import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'custom_data.g.dart';

@JsonSerializable(explicitToJson: true)
class CustomData extends Equatable {
  const CustomData({
    this.customData1,
    this.customData2,
    this.customData3,
    this.customData4,
    this.customData5,
    this.customData6,
    this.customData7,
    this.customData8,
    this.customData9,
    this.customData10,
    this.customData11,
    this.customData12,
    this.customData13,
    this.customData14,
    this.customData15,
    this.customData16,
    this.customData17,
    this.customData18,
    this.customData19,
    this.customData20,
    this.customData21,
    this.customData22,
    this.customData23,
    this.customData24,
    this.customData25,
    this.customData26,
    this.customData27,
    this.customData28,
    this.customData29,
    this.customData30,
    this.experimentName,
  });

  factory CustomData.fromJson(Map<String, dynamic> json) {
    return _$CustomDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CustomDataToJson(this);

  /// Optional free-form data
  @JsonKey(name: 'customData1')
  final String? customData1;

  /// Optional free-form data
  @JsonKey(name: 'customData2')
  final String? customData2;

  /// Optional free-form data
  @JsonKey(name: 'customData3')
  final String? customData3;

  /// Optional free-form data
  @JsonKey(name: 'customData4')
  final String? customData4;

  /// Optional free-form data
  @JsonKey(name: 'customData5')
  final String? customData5;

  /// Optional free-form data. Not enabled by default.
  /// Must be activated for your organization
  @JsonKey(name: 'customData6')
  final String? customData6;

  /// Optional free-form data. Not enabled by default.
  /// Must be activated for your organization
  @JsonKey(name: 'customData7')
  final String? customData7;

  /// Optional free-form data. Not enabled by default.
  /// Must be activated for your organization
  @JsonKey(name: 'customData8')
  final String? customData8;

  /// Optional free-form data. Not enabled by default.
  /// Must be activated for your organization
  @JsonKey(name: 'customData9')
  final String? customData9;

  /// Optional free-form data. Not enabled by default.
  /// Must be activated for your organization
  @JsonKey(name: 'customData10')
  final String? customData10;

  /// Optional free-form data. Not enabled by default.
  /// Must be activated for your organization
  @JsonKey(name: 'customData11')
  final String? customData11;

  /// Optional free-form data. Not enabled by default.
  /// Must be activated for your organization
  @JsonKey(name: 'customData12')
  final String? customData12;

  /// Optional free-form data. Not enabled by default.
  /// Must be activated for your organization
  @JsonKey(name: 'customData13')
  final String? customData13;

  /// Optional free-form data. Not enabled by default.
  /// Must be activated for your organization
  @JsonKey(name: 'customData14')
  final String? customData14;

  /// Optional free-form data. Not enabled by default.
  /// Must be activated for your organization
  @JsonKey(name: 'customData15')
  final String? customData15;

  /// Optional free-form data. Not enabled by default.
  /// Must be activated for your organization
  @JsonKey(name: 'customData16')
  final String? customData16;

  /// Optional free-form data. Not enabled by default.
  /// Must be activated for your organization
  @JsonKey(name: 'customData17')
  final String? customData17;

  /// Optional free-form data. Not enabled by default.
  /// Must be activated for your organization
  @JsonKey(name: 'customData18')
  final String? customData18;

  /// Optional free-form data. Not enabled by default.
  /// Must be activated for your organization
  @JsonKey(name: 'customData19')
  final String? customData19;

  /// Optional free-form data. Not enabled by default.
  /// Must be activated for your organization
  @JsonKey(name: 'customData20')
  final String? customData20;

  /// Optional free-form data. Not enabled by default.
  /// Must be activated for your organization
  @JsonKey(name: 'customData21')
  final String? customData21;

  /// Optional free-form data. Not enabled by default.
  /// Must be activated for your organization
  @JsonKey(name: 'customData22')
  final String? customData22;

  /// Optional free-form data. Not enabled by default.
  /// Must be activated for your organization
  @JsonKey(name: 'customData23')
  final String? customData23;

  /// Optional free-form data. Not enabled by default.
  /// Must be activated for your organization
  @JsonKey(name: 'customData24')
  final String? customData24;

  /// Optional free-form data. Not enabled by default.
  /// Must be activated for your organization
  @JsonKey(name: 'customData25')
  final String? customData25;

  /// Optional free-form data. Not enabled by default.
  /// Must be activated for your organization
  @JsonKey(name: 'customData26')
  final String? customData26;

  /// Optional free-form data. Not enabled by default.
  /// Must be activated for your organization
  @JsonKey(name: 'customData27')
  final String? customData27;

  /// Optional free-form data. Not enabled by default.
  /// Must be activated for your organization
  @JsonKey(name: 'customData28')
  final String? customData28;

  /// Optional free-form data. Not enabled by default.
  /// Must be activated for your organization
  @JsonKey(name: 'customData29')
  final String? customData29;

  /// Optional free-form data. Not enabled by default.
  /// Must be activated for your organization
  @JsonKey(name: 'customData30')
  final String? customData30;

  /// Free form-data field that can be used for A/B testing
  @JsonKey(name: 'experimentName')
  final String? experimentName;

  @override
  List<Object?> get props => [
        customData1,
        customData2,
        customData3,
        customData4,
        customData5,
        customData6,
        customData7,
        customData8,
        customData9,
        customData10,
        customData11,
        customData12,
        customData13,
        customData14,
        customData15,
        customData16,
        customData17,
        customData18,
        customData19,
        customData20,
        customData21,
        customData22,
        customData23,
        customData24,
        customData25,
        customData26,
        customData27,
        customData28,
        customData29,
        customData30,
        experimentName,
      ];
}
