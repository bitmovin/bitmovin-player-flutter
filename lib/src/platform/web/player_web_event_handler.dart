import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/platform/web/bitmovin_player_web_api.dart';
import 'package:bitmovin_player/src/platform/web/conversion.dart';
import 'package:js/js.dart';
import 'package:logger/logger.dart';

class PlayerWebEventHandler {
  PlayerWebEventHandler(this._player, this._onPlatformEvent) {
    _player
      ..on('play', allowInterop(_onPlay))
      ..on('playing', allowInterop(_onPlaying))
      ..on('paused', allowInterop(_onPaused))
      ..on('timechanged', allowInterop(_onTimeChanged))
      ..on('seek', allowInterop(_onSeek))
      ..on('seeked', allowInterop(_onSeeked))
      ..on('timeshift', allowInterop(_onTimeShift))
      ..on('timeshifted', allowInterop(_onTimeShifted))
      ..on('playbackfinished', allowInterop(_onPlaybackFinished))
      ..on('error', allowInterop(_onError))
      ..on('muted', allowInterop(_onMuted))
      ..on('unmuted', allowInterop(_onUnmuted))
      ..on('warning', allowInterop(_onWarning))
      ..on('ready', allowInterop(_onReady))
      ..on('sourceloaded', allowInterop(_onSourceLoaded))
      ..on('sourceunloaded', allowInterop(_onSourceUnloaded));
  }

  final BitmovinPlayerJs _player;
  final void Function(Event event) _onPlatformEvent;
  final Logger _logger = Logger();

  Source? get _getSource {
    final currentSourceJs = _player.getSource();
    if (currentSourceJs == null) {
      return null;
    }

    return currentSourceJs.toSource(_player.getStreamType());
  }

  void _onPlay(PlaybackEventJs event) {
    _onPlatformEvent(event.toPlayEvent());
  }

  void _onPlaying(PlaybackEventJs event) {
    _onPlatformEvent(event.toPlayingEvent());
  }

  void _onPaused(PlaybackEventJs event) {
    _onPlatformEvent(event.toPausedEvent());
  }

  void _onTimeChanged(PlaybackEventJs event) {
    _onPlatformEvent(event.toTimeChangedEvent());
  }

  void _onSeek(SeekEventJs event) {
    final currentSource = _getSource;
    if (currentSource == null) {
      _logger.w('onSeek: Could not receive current source from web player');
      return;
    }

    _onPlatformEvent(event.toSeekEvent(currentSource));
  }

  void _onSeeked(PlayerEventBaseJs event) {
    _onPlatformEvent(event.toSeekedEvent());
  }

  void _onTimeShift(TimeShiftEventJs event) {
    _onPlatformEvent(event.toTimeShiftEvent());
  }

  void _onTimeShifted(PlayerEventBaseJs event) {
    _onPlatformEvent(event.toTimeShiftedEvent());
  }

  void _onPlaybackFinished(PlayerEventBaseJs event) {
    _onPlatformEvent(event.toPlaybackFinishedEvent());
  }

  void _onError(ErrorEventJs event) {
    _onPlatformEvent(event.toErrorEvent());
  }

  void _onMuted(UserInteractionEventJs event) {
    _onPlatformEvent(event.toMutedEvent());
  }

  void _onUnmuted(UserInteractionEventJs event) {
    _onPlatformEvent(event.toUnmutedEvent());
  }

  void _onWarning(WarningEventJs event) {
    _onPlatformEvent(event.toWarningEvent());
  }

  void _onReady(PlayerEventBaseJs event) {
    _onPlatformEvent(event.toReadyEvent());
  }

  void _onSourceLoaded(PlayerEventBaseJs event) {
    final currentSource = _getSource;
    if (currentSource == null) {
      _logger.w(
        'onSourceLoaded: Could not receive current source from web player',
      );
      return;
    }

    _onPlatformEvent(event.toSourceLoadedEvent(currentSource));
  }

  void _onSourceUnloaded(PlayerEventBaseJs event) {
    _onPlatformEvent(event.toSourceUnloadedEvent());
  }
}
