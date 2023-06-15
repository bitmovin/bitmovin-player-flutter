import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fairplay_config.g.dart';

@JsonSerializable(explicitToJson: true)
class FairplayConfig extends Equatable {
  const FairplayConfig({
    this.licenseUrl,
    this.certificateUrl,
    this.licenseRequestHeaders,
    this.certificateRequestHeaders,
    this.prepareCertificate,
    this.prepareMessage,
    this.prepareSyncMessage,
    this.prepareLicense,
    this.prepareLicenseServerUrl,
    this.prepareContentId,
  });

  factory FairplayConfig.fromJson(Map<String, dynamic> json) =>
      _$FairplayConfigFromJson(json);

  /// The DRM license acquisition URL.
  @JsonKey(name: 'licenseUrl')
  final String? licenseUrl;

  /// The URL to the FairPlay Streaming certificate of the license server.
  @JsonKey(name: 'certificateUrl')
  final String? certificateUrl;

  /// A dictionary to specify custom HTTP headers for the license request.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, String>? licenseRequestHeaders;

  /// A dictionary to specify custom HTTP headers for the certificate request.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, String>? certificateRequestHeaders;

  /// A block to prepare the loaded certificate before building SPC data and
  /// passing it into the system. This is needed if the server responds with
  /// anything else than the certificate, e.g. if the certificate is wrapped
  /// into a JSON object. The server response for the certificate request is
  /// passed as parameter “as is”.
  ///
  /// Note that both the passed `certificate` data and this block return value
  /// should be a Base64 string. So use whatever solution suits you best to
  /// handle Base64 in Flutter.
  ///
  /// @param certificate - Base64 encoded certificate data.
  /// @returns The processed Base64 encoded certificate.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String Function(String)? prepareCertificate;

  /// A block to prepare the data which is sent as the body of the POST license
  /// request. As many DRM providers expect different, vendor-specific messages,
  /// this can be done using this user-defined block.
  ///
  /// Note that both the passed `message` data and this block return value
  /// should be a Base64 string. So use whatever solution suits you best to
  /// handle Base64 in Flutter.
  ///
  /// @param message - Base64 encoded message data.
  /// @param assetId - Stream asset ID.
  /// @returns The processed Base64 encoded message.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String Function(String, String)? prepareMessage;

  /// A block to prepare the data which is sent as the body of the POST request
  /// for syncing the DRM license information.
  ///
  /// Note that both the passed `syncMessage` data and this block return value
  /// should be a Base64 string. So use whatever solution suits you best to
  /// handle Base64 in Flutter.
  ///
  /// @param message - Base64 encoded message data.
  /// @param assetId - Asset ID.
  /// @returns The processed Base64 encoded message.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String Function(String, String)? prepareSyncMessage;

  /// A block to prepare the loaded CKC Data before passing it to the system.
  /// This is needed if the server responds with anything else than the license,
  /// e.g. if the license is wrapped into a JSON object.
  ///
  /// Note that both the passed `license` data and this block return value
  /// should be a Base64 string. So use whatever solution suits you best to
  /// handle Base64 in Flutter.
  ///
  /// @param license - Base64 encoded license data.
  /// @returns The processed Base64 encoded license.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String Function(String)? prepareLicense;

  /// A block to prepare the URI (without the skd://) from the HLS manifest
  /// before passing it to the system. This is needed if the server responds
  /// with anything else than the license, e.g. if the license is wrapped into a
  /// JSON object.
  ///
  /// Note that both the passed `licenseServerUrl` data and this block return
  /// value should be a Base64 string. So use whatever solution suits you best
  /// to handle Base64 in Flutter.
  ///
  /// @param licenseServerUrl - Base64 encoded license server URL.
  /// @returns The processed Base64 encoded license server URL.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String Function(String)? prepareLicenseServerUrl;

  /// A block to prepare the content ID from the HLS manifest before passing it
  /// to the system. This is needed if the server responds with anything else
  /// than the license, e.g. if the license is wrapped into a JSON object.
  ///
  /// Note that both the passed `contentId` data and this block return value
  /// should be a Base64 string. So use whatever solution suits you best to
  /// handle Base64 in Flutter.
  ///
  /// @param contentId - Base64 encoded content ID.
  /// @returns The processed Base64 encoded content ID.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String Function(String)? prepareContentId;

  /// Converts this [FairplayConfig] into JSON friendly Map<String, dynamic>
  Map<String, dynamic> toJson() => _$FairplayConfigToJson(this);

  @override
  List<Object?> get props => [
        licenseUrl,
        certificateUrl,
      ];
}
