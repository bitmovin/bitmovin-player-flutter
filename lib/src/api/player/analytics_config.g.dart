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
    );

Map<String, dynamic> _$AnalyticsConfigToJson(AnalyticsConfig instance) =>
    <String, dynamic>{
      'licenseKey': instance.licenseKey,
      'adTrackingDisabled': instance.adTrackingDisabled,
      'randomizeUserId': instance.randomizeUserId,
      'retryPolicy': _$RetryPolicyEnumMap[instance.retryPolicy]!,
      'backendUrl': instance.backendUrl,
    };

const _$RetryPolicyEnumMap = {
  RetryPolicy.noRetry: 'noRetry',
  RetryPolicy.shortTerm: 'shortTerm',
  RetryPolicy.longTerm: 'longTerm',
};
