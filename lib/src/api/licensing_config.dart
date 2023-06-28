import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'licensing_config.g.dart';

/// Configures the behavior of the player license evaluation.
@JsonSerializable(explicitToJson: true)
class LicensingConfig extends Equatable {
  const LicensingConfig({
    required this.delay,
  });

  factory LicensingConfig.fromJson(Map<String, dynamic> json) {
    return _$LicensingConfigFromJson(json);
  }

  /// The delay in milliseconds until the licensing call is issued.
  /// Default value is 0. Maximum value is 30000 (i.e. 30 seconds).
  @JsonKey(name: 'delay', defaultValue: 0)
  final int delay;

  Map<String, dynamic> toJson() => _$LicensingConfigToJson(this);

  @override
  List<Object?> get props => [delay];
}
