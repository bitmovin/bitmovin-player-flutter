// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_shifted_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeShiftedEvent _$TimeShiftedEventFromJson(Map<String, dynamic> json) =>
    TimeShiftedEvent(
      timestamp: (json['timestamp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TimeShiftedEventToJson(TimeShiftedEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
    };
