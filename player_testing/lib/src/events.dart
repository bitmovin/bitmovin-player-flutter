import 'package:bitmovin_player/bitmovin_player.dart';

typedef E = Events;

abstract class Events {
  static const play = PlayEvent(time: 0, timestamp: 0);
  static const playing = PlayingEvent(time: 0, timestamp: 0);
  static const ready = ReadyEvent(timestamp: 0);
  static const timeShift = TimeShiftEvent(position: 0, target: 0, timestamp: 0);
  static const timeShifted = TimeShiftedEvent(timestamp: 0);
  static const timeChanged = TimeChangedEvent(time: 0, timestamp: 0);
}
