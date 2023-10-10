import 'package:bitmovin_player/src/casting_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'casting_config.g.dart';

/// Configures remote playback behavior.
@JsonSerializable(explicitToJson: true)
class RemoteControlConfig extends Equatable {
  const RemoteControlConfig({
    this.receiverStylesheetUrl,
    this.customReceiverConfig = const {},
    this.isCastEnabled = true,
    this.sendManifestRequestsWithCredentials = false,
    this.sendSegmentRequestsWithCredentials = false,
    this.sendDrmLicenseRequestsWithCredentials = false,
  });

  factory RemoteControlConfig.fromJson(Map<String, dynamic> json) {
    return _$RemoteControlConfigFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RemoteControlConfigToJson(this);

  /// A URL to a CSS file the receiver app loads to style the receiver app.
  /// Default value is `null`, indicating that the default CSS of the receiver
  /// app will be used.
  final String? receiverStylesheetUrl;

  /// A Map containing custom configuration values that are sent to the remote
  /// control receiver.
  /// Default value is an empty map.
  final Map<String, String> customReceiverConfig;

  /// Whether casting is enabled.
  /// Default value is `true`.
  ///
  /// Has no effect if the `BitmovinCastManager` is not initialized before the
  /// `Player` is created with this configuration.
  final bool isCastEnabled;

  /// Indicates whether cookies and credentials will be sent along manifest
  /// requests on the cast receiver
  /// Default value is `false`.
  final bool sendManifestRequestsWithCredentials;

  /// Indicates whether cookies and credentials will be sent along segment
  /// requests on the cast receiver
  /// Default value is `false`.
  final bool sendSegmentRequestsWithCredentials;

  /// Indicates whether cookies and credentials will be sent along DRM licence
  /// requests on the cast receiver
  /// Default value is `false`.
  final bool sendDrmLicenseRequestsWithCredentials;

  @override
  List<Object?> get props => [
    receiverStylesheetUrl,
    customReceiverConfig,
    isCastEnabled,
    sendManifestRequestsWithCredentials,
    sendSegmentRequestsWithCredentials,
    sendDrmLicenseRequestsWithCredentials,
  ];
}

/// The options to be used for initializing [BitmovinCastManager]
@JsonSerializable(explicitToJson: true)
class BitmovinCastManagerOptions extends Equatable {
  const BitmovinCastManagerOptions({this.applicationId, this.messageNamespace});

  factory BitmovinCastManagerOptions.fromJson(Map<String, dynamic> json) {
    return _$BitmovinCastManagerOptionsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BitmovinCastManagerOptionsToJson(this);

  /// ID of receiver application.
  /// Using `null` value will result in using the default application ID
  final String? applicationId;
  /// A custom message namespace to be used for communication between sender and
  /// receiver.
  /// Using `null` value will result in using the default message namespace
  final String? messageNamespace;

  @override
  List<Object?> get props => [
    applicationId,
    messageNamespace,
  ];
}
