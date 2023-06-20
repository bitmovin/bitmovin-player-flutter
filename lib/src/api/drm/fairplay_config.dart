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

  /// A function to prepare the loaded certificate before building SPC data
  /// and passing it into the system. This is needed if the server responds with
  /// anything else than the certificate, e.g. if the certificate is wrapped
  /// into a JSON object. The server response for the certificate request is
  /// passed as parameter “as is”.
  ///
  /// Note that both the passed `certificate` data and the returned processed
  /// certificate data is expected be a Base64 encoded [String].
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String Function(String certificate)? prepareCertificate;

  /// A function to prepare the SPC data which is sent as the body of the POST
  /// license request. As many DRM providers expect different, vendor-specific
  /// messages, this can be done using this user-defined function.
  ///
  /// Note that both the passed `spcData` and the returned processed SPC data
  /// is expected to be a Base64 encoded [String].
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String Function(String spcData, String assetId)? prepareMessage;

  /// A function to prepare the sync SPC data which is sent as the body of the
  /// POST request for syncing the DRM license information.
  ///
  /// Note that both the passed `syncSpcData` data and the returned processed
  /// sync SPC data is expected to be a Base64 encoded [String].
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String Function(String syncSpcData, String assetId)? prepareSyncMessage;

  /// A function to prepare the loaded CKC Data before passing it to the system.
  /// This is needed if the server responds with anything else than the license,
  /// e.g. if the license is wrapped into a JSON object.
  ///
  /// Note that both the passed `ckc` license data and the returned processed
  /// CKC license data is expected to be a Base64 encoded [String].
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String Function(String ckc)? prepareLicense;

  /// A function to prepare the URI (without the skd://) from the HLS manifest
  /// before passing it to the system.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String Function(String licenseServerUrl)? prepareLicenseServerUrl;

  /// A function to prepare the `contentId`, which is sent to the FairPlay
  /// Streaming license server as request body, and which is used to build the
  /// SPC data. As many DRM providers expect different, vendor-specific
  /// messages, this can be done using this user-defined function. The parameter
  /// is the skd:// URI extracted from the HLS manifest (m3u8) and the return
  /// value should be the processed `contentId` as a [String].
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String Function(String contentId)? prepareContentId;

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
