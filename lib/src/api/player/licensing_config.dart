import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'licensing_config.g.dart';

/// Configures the behavior of the player license evaluation.
@JsonSerializable(explicitToJson: true)
class LicensingConfig extends Equatable {
  const LicensingConfig({
    this.delay = 0,
  });

  factory LicensingConfig.fromJson(Map<String, dynamic> json) {
    return _$LicensingConfigFromJson(json);
  }

  /// The delay in milliseconds until the licensing call is issued.
  /// Default value is 0. Maximum value is 30000 (i.e. 30 seconds).
  ///
  /// This is only supported on Android.
  @JsonKey(name: 'delay')
  final int delay;

  Map<String, dynamic> toJson() => _$LicensingConfigToJson(this);

  @override
  List<Object?> get props => [delay];
}
