// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_shift_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeShiftEvent _$TimeShiftEventFromJson(Map<String, dynamic> json) =>
    TimeShiftEvent(
      position: (json['position'] as num).toDouble(),
      target: (json['target'] as num).toDouble(),
      timestamp: (json['timestamp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TimeShiftEventToJson(TimeShiftEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'position': instance.position,
      'target': instance.target,
    };
