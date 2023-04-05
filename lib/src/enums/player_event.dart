
import 'package:json_annotation/json_annotation.dart';

/// Enumerated values that indicates
/// the state of the current event of the player.
enum PlayerEvent {
  /// Indicates that the player is active.
  @JsonValue('active')
  active,

  /// Indicates that the player is ready.
  @JsonValue('ready')
  ready,

  /// Indicates that the play command is invoked.
  @JsonValue('play')
  play,

  /// Indicates that the player has been paused.
  @JsonValue('pause')
  pause,

  /// Indicates that the player has stopped.
  @JsonValue('stop')
  stop,

  /// Indicates that the current time of the playback has changed.
  @JsonValue('time_changed')
  timechanged,

  /// Indicates that the player is playing.
  @JsonValue('playing')
  playing,

  /// Indicates that the player has finished playback.
  @JsonValue('playback_finished')
  playbackfinished,

  /// Indicates that the player has been destroyed.
  @JsonValue('destroy')
  destroy,

  /// Indicates that the player is being loaded.
  @JsonValue('load')
  load,

  /// Indicates that the player has been loaded.
  @JsonValue('loaded')
  loaded,

  /// Indicates that the player has encountered a warning.
  @JsonValue('warning')
  warning,

  /// Indicates that the player has encountered a error.
  @JsonValue('error')
  error,

  /// Indicates that buffering has started.
  @JsonValue('buffering_started')
  bufferStarted,

  /// Indicates that buffering has ended.
  @JsonValue('buffering_ended')
  bufferingEnded,

  /// when source can't be loaded due to unknown cause
  @JsonValue('source_error')
  sourceError,

  /// when source can't be loaded due to network errors
  @JsonValue('network_error')
  networkError,

  /// Indicates that first frame has been rendered.
  @JsonValue('rendered_first_frame')
  renderedFirstFrame,

  /// Indicates that seek has stopped.
  @JsonValue('seeked')
  seeked,

  /// Indicates that seek has stopped.
  @JsonValue('seek')
  seek,
}

extension PlayerEventExtension on PlayerEvent {
  static const names = {
    PlayerEvent.active: 'active',
    PlayerEvent.ready: 'ready',
    PlayerEvent.play: 'play',
    PlayerEvent.pause: 'pause',
    PlayerEvent.stop: 'stop',
    PlayerEvent.timechanged: 'time_changed',
    PlayerEvent.playing: 'playing',
    PlayerEvent.playbackfinished: 'playback_finished',
    PlayerEvent.bufferStarted: 'buffering_started',
    PlayerEvent.bufferingEnded: 'buffering_ended',
    PlayerEvent.seeked: 'seeked',
    PlayerEvent.renderedFirstFrame: 'rendered_first_frame',
  };

  String? get name => names[this];
}
