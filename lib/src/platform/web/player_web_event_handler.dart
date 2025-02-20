import 'dart:js_interop';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/platform/web/bitmovin_player_web_api.dart';
import 'package:bitmovin_player/src/platform/web/conversion.dart';
import 'package:logger/logger.dart';

class PlayerWebEventHandler {
  PlayerWebEventHandler(this._player, this._onPlatformEvent) {
    _player
      ..on('play', _onPlay.toJS)
      ..on('playing', _onPlaying.toJS)
      ..on('paused', _onPaused.toJS)
      ..on('timechanged', _onTimeChanged.toJS)
      ..on('seek', _onSeek.toJS)
      ..on('seeked', _onSeeked.toJS)
      ..on('timeshift', _onTimeShift.toJS)
      ..on('timeshifted', _onTimeShifted.toJS)
      ..on('playbackfinished', _onPlaybackFinished.toJS)
      ..on('error', _onError.toJS)
      ..on('muted', _onMuted.toJS)
      ..on('unmuted', _onUnmuted.toJS)
      ..on('warning', _onWarning.toJS)
      ..on('ready', _onReady.toJS)
      ..on('sourceloaded', _onSourceLoaded.toJS)
      ..on('sourceunloaded', _onSourceUnloaded.toJS)
      ..on('castavailable', _onCastAvailable.toJS)
      ..on('caststart', _onCastStart.toJS)
      ..on('caststarted', _onCastStarted.toJS)
      ..on('caststopped', _onCastStopped.toJS)
      ..on('castwaitingfordevice', _onCastWaitingForDevice.toJS);
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

  void _onCastAvailable(CastAvailableEventJs event) {
    _onPlatformEvent(event.toCastAvailableEvent());
  }

  void _onCastStart(PlayerEventBaseJs event) {
    _onPlatformEvent(event.toCastStartEvent());
  }

  void _onCastStarted(CastStartedEventJs event) {
    _onPlatformEvent(event.toCastStartedEvent());
  }

  void _onCastStopped(PlayerEventBaseJs event) {
    _onPlatformEvent(event.toCastStoppedEvent());
  }

  void _onCastWaitingForDevice(CastWaitingForDeviceEventJs event) {
    _onPlatformEvent(event.toCastWaitingForDeviceEvent());
  }
}
