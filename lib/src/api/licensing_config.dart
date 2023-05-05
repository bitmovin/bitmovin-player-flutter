import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'licensing_config.g.dart';

@JsonSerializable(explicitToJson: true)
class LicensingConfig extends Equatable {
  const LicensingConfig({
    required this.delay,
  });

  factory LicensingConfig.fromJson(Map<String, dynamic> json) {
    return _$LicensingConfigFromJson(json);
  }

  @JsonKey(name: 'delay', defaultValue: 0)
  final int delay;

  Map<String, dynamic> toJson() => _$LicensingConfigToJson(this);

  @override
  List<Object?> get props => [delay];
}
