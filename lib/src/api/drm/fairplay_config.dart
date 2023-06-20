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
  /// Note that both the passed `certificate` data and the return value
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
  /// Note that both the passed `spcData` data and the return value
  /// should be a Base64 string. So use whatever solution suits you best to
  /// handle Base64 in Flutter.
  ///
  /// @param spcData - Base64 encoded spc data.
  /// @param assetId - Stream asset ID.
  /// @returns The processed Base64 encoded SPC data.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String Function(String, String)? prepareMessage;

  /// A block to prepare the data which is sent as the body of the POST request
  /// for syncing the DRM license information.
  ///
  /// Note that both the passed `syncSpcData` data and the return value
  /// should be a Base64 string. So use whatever solution suits you best to
  /// handle Base64 in Flutter.
  ///
  /// @param syncSpcData - Base64 encoded sync SPC data.
  /// @param assetId - Asset ID.
  /// @returns The processed Base64 encoded sync SPC data.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String Function(String, String)? prepareSyncMessage;

  /// A block to prepare the loaded CKC Data before passing it to the system.
  /// This is needed if the server responds with anything else than the license,
  /// e.g. if the license is wrapped into a JSON object.
  ///
  /// Note that both the passed `ckc` license data and the return value
  /// should be a Base64 string. So use whatever solution suits you best to
  /// handle Base64 in Flutter.
  ///
  /// @param ckc - Base64 encoded CKC license data.
  /// @returns The processed Base64 encoded CKC license data.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String Function(String)? prepareLicense;

  /// A block to prepare the URI (without the skd://) from the HLS manifest
  /// before passing it to the system.
  ///
  /// @param licenseServerUrl - license server URL string.
  /// @returns The processed license server URL string.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String Function(String)? prepareLicenseServerUrl;

  /// A block to prepare the `contentId`, which is sent to the FairPlay
  /// Streaming license server as request body, and which is used to build the
  /// SPC data. As many DRM providers expect different, vendor-specific
  /// messages, this can be done using this user-defined block. The parameter is
  /// the skd:// URI extracted from the HLS manifest (m3u8) and the return value
  /// should be the contentID as a string.
  ///
  /// @param contentId - Extracted content id string.
  /// @returns The processed contentId.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String Function(String)? prepareContentId;

  /// Converts this [FairplayConfig] into JSON friendly Map<String, dynamic>
  Map<String, dynamic> toJson() {
    final jsonData = _$FairplayConfigToJson(this);

    jsonData['prepareMessage'] = prepareMessage != null;
    jsonData['prepareContentId'] = prepareContentId != null;
    jsonData['prepareCertificate'] = prepareCertificate != null;
    jsonData['prepareLicense'] = prepareLicense != null;
    jsonData['prepareLicenseServerUrl'] = prepareLicenseServerUrl != null;
    jsonData['prepareSyncMessage'] = prepareSyncMessage != null;

    return jsonData;
  }

  @override
  List<Object?> get props => [
        licenseUrl,
        certificateUrl,
      ];
}
