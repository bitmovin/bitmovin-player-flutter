import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'widevine_config.g.dart';

/// Provides configuration options for Widevine DRM.
/// Only supported on Android.
@JsonSerializable(explicitToJson: true)
class WidevineConfig extends Equatable {
  const WidevineConfig({
    this.licenseUrl,
    this.httpHeaders,
    this.prepareMessage,
    this.prepareLicense,
    this.preferredSecurityLevel,
    this.shouldKeepDrmSessionsAlive = false,
  });

  factory WidevineConfig.fromJson(Map<String, dynamic> json) =>
      _$WidevineConfigFromJson(json);

  /// The DRM license acquisition URL.
  @JsonKey(name: 'licenseUrl')
  final String? licenseUrl;

  /// An optional map containing the HTTP request headers.
  @JsonKey(name: 'httpHeaders')
  final Map<String, String>? httpHeaders;

  /// Is called with the key message as provided by the content decryption
  /// module (CDM). This function can be used to customize the license
  /// acquisition message which will be sent to the license acquisition server.
  ///
  /// Note that both the passed `keyMessage` data and the returned processed
  /// key message are expected to be a Base64 encoded [String].
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String Function(String keyMessage)? prepareMessage;

  /// Is called with the response returned by the DRM license server for the DRM
  /// license request. Can be used to process the response of the Widevine
  /// servers. The returned [String] is treated as the new license response.
  ///
  /// Note that both the passed `licenseResponse` data and the returned
  /// processed license response are expected to be a Base64 encoded [String].
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String Function(String licenseResponse)? prepareLicense;

  /// The preferred security level as a [String]. If set to `null`, the player
  /// will choose a fitting security level. The default value is `null`.
  @JsonKey(name: 'preferredSecurityLevel')
  final String? preferredSecurityLevel;

  /// Indicates if the DRM sessions should be kept alive after a source is
  /// unloaded. This allows DRM sessions to be reused over several different
  /// sources with the same DRM configuration as well as the same DRM scheme
  /// information. The default value is `false`.
  @JsonKey(name: 'shouldKeepDrmSessionsAlive')
  final bool shouldKeepDrmSessionsAlive;

  /// Converts this [WidevineConfig] into JSON friendly Map<String, dynamic>
  Map<String, dynamic> toJson() {
    final jsonData = _$WidevineConfigToJson(this);

    jsonData['prepareMessage'] = prepareMessage != null;
    jsonData['prepareLicense'] = prepareLicense != null;

    return jsonData;
  }

  @override
  List<Object?> get props => [
        licenseUrl,
        httpHeaders,
        preferredSecurityLevel,
        shouldKeepDrmSessionsAlive,
      ];
}
