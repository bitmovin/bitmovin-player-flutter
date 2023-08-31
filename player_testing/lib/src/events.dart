import 'package:bitmovin_player/bitmovin_player.dart';

typedef E = Events;

abstract class Events {
  static const play = PlayEvent(time: 0, timestamp: 0);
  static const playing = PlayingEvent(time: 0, timestamp: 0);
  static const paused = PausedEvent(time: 0, timestamp: 0);
  static const ready = ReadyEvent(timestamp: 0);
  static const seek = SeekEvent(
    from: _seekPosition,
    to: _seekPosition,
    timestamp: 0,
  );
  static const seeked = SeekedEvent(timestamp: 0);
  static const timeShift = TimeShiftEvent(position: 0, target: 0, timestamp: 0);
  static const timeShifted = TimeShiftedEvent(timestamp: 0);
  static const timeChanged = TimeChangedEvent(time: 0, timestamp: 0);

  // Private dummy objects which are used to create event objects
  static const _seekPosition = SeekPosition(
    source: _source,
    time: 0,
  );
  static const _source = Source(
    sourceConfig: SourceConfig(
      url: '',
      type: SourceType.hls,
    ),
  );
}
