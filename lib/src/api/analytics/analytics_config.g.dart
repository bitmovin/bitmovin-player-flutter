// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalyticsConfig _$AnalyticsConfigFromJson(Map<String, dynamic> json) =>
    AnalyticsConfig(
      licenseKey: json['licenseKey'] as String,
      adTrackingDisabled: json['adTrackingDisabled'] as bool? ?? false,
      randomizeUserId: json['randomizeUserId'] as bool? ?? false,
      retryPolicy:
          $enumDecodeNullable(_$RetryPolicyEnumMap, json['retryPolicy']) ??
              RetryPolicy.noRetry,
      backendUrl: json['backendUrl'] as String? ??
          'https://analytics-ingress-global.bitmovin.com/',
      defaultMetadata: json['defaultMetadata'] == null
          ? const DefaultMetadata()
          : DefaultMetadata.fromJson(
              json['defaultMetadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnalyticsConfigToJson(AnalyticsConfig instance) =>
    <String, dynamic>{
      'licenseKey': instance.licenseKey,
      'adTrackingDisabled': instance.adTrackingDisabled,
      'randomizeUserId': instance.randomizeUserId,
      'retryPolicy': _$RetryPolicyEnumMap[instance.retryPolicy]!,
      'backendUrl': instance.backendUrl,
      'defaultMetadata': instance.defaultMetadata.toJson(),
    };

const _$RetryPolicyEnumMap = {
  RetryPolicy.noRetry: 'NoRetry',
  RetryPolicy.shortTerm: 'ShortTerm',
  RetryPolicy.longTerm: 'LongTerm',
};
