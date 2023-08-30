import 'package:bitmovin_player/src/api/analytics/default_metadata.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'analytics_config.g.dart';

/// Configures the behavior of the player analytics module.
@JsonSerializable(explicitToJson: true)
class AnalyticsConfig extends Equatable {
  const AnalyticsConfig({
    required this.licenseKey,
    this.adTrackingDisabled = false,
    this.randomizeUserId = false,
    this.retryPolicy = RetryPolicy.noRetry,
    this.backendUrl = 'https://analytics-ingress-global.bitmovin.com/',
    this.defaultMetadata = const DefaultMetadata(),
  });

  factory AnalyticsConfig.fromJson(Map<String, dynamic> json) {
    return _$AnalyticsConfigFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AnalyticsConfigToJson(this);

  /// The analytics license key
  @JsonKey(name: 'licenseKey')
  final String licenseKey;

  /// Value indicating if ad tracking is disabled.
  /// Default is `false`
  @JsonKey(name: 'adTrackingDisabled')
  final bool adTrackingDisabled;

  /// Generate a random UserId for the session
  /// Default is `false`
  @JsonKey(name: 'randomizeUserId')
  final bool randomizeUserId;

  /// Specifies the retry behavior in case an analytics request cannot be sent
  /// to the analytics backend.
  /// See [RetryPolicy] for the available settings.
  /// Default is [RetryPolicy.noRetry]
  @JsonKey(name: 'retryPolicy')
  final RetryPolicy retryPolicy;

  /// The URL of the Bitmovin Analytics backend.
  /// Default is the Bitmovin backend URL
  @JsonKey(name: 'backendUrl')
  final String backendUrl;

  @JsonKey(name:'defaultMetadata')
  final DefaultMetadata defaultMetadata;

  @override
  List<Object?> get props => [
        licenseKey,
        adTrackingDisabled,
        randomizeUserId,
        retryPolicy,
        backendUrl,
      ];
}

enum RetryPolicy {
  /// No retry in case an analytics request cannot be sent
  /// to the analytics backend
  @JsonValue('NO_RETRY')
  noRetry,

  /// A failing request is retried for a maximum of 300 seconds,
  /// while the collector instance is still alive.
  /// The initial license call to verify the analytics license
  /// needs to be successful.
  @JsonValue('SHORT_TERM')
  shortTerm,

  /// A failing request is retried for up to 14 days.
  /// The analytics request is stored
  /// permanently until it is sent successfully or the max lifetime is reached.
  /// This policy can be used for tracking of offline playback.
  /// See https://developer.bitmovin.com/playback/docs/is-tracking-of-analytics-data-support-in-offline-mode for more information.
  @JsonValue('LONG_TERM')
  longTerm,
}
