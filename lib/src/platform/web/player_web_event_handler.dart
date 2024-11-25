import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/platform/web/bitmovin_player_web_api.dart';
import 'package:bitmovin_player/src/platform/web/conversion.dart';
import 'package:js/js.dart';

class PlayerWebEventHandler {
  PlayerWebEventHandler(this._player, this._onPlatformEvent) {
    _player
      ..on('play', allowInterop(_onPlay))
      ..on('playing', allowInterop(_onPlaying))
      ..on('paused', allowInterop(_onPaused))
      ..on('timechanged', allowInterop(_onTimeChanged))
      ..on('seek', allowInterop(_onSeekEvent))
      ..on('seeked', allowInterop(_onSeekedEvent));
  }

  final BitmovinPlayerJs _player;
  final void Function(Event event) _onPlatformEvent;

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

  void _onSeekEvent(SeekEventJs event) {
    final currentSourceJs = _player.getSource();
    if (currentSourceJs == null) {
      return;
    }

    _onPlatformEvent(
      event.toSeekEvent(
        currentSourceJs.toSource(_player.getStreamType()),
      ),
    );
  }

  void _onSeekedEvent(PlayerEventBaseJs event) {
    _onPlatformEvent(event.toSeekedEvent());
  }
}
