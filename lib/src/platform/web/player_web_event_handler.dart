import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/platform/web/bitmovin_player_web_api.dart';
import 'package:bitmovin_player/src/platform/web/conversion.dart';
import 'package:js/js.dart';

class PlayerWebEventHandler {
  PlayerWebEventHandler(this._player, this._onPlatformEvent) {
    _player
      ..on('play', allowInterop(_onPlaybackEvent))
      ..on('seek', allowInterop(_onSeekEvent));
  }

  final BitmovinPlayerJs _player;
  final void Function(Event event) _onPlatformEvent;

  void _onPlaybackEvent(PlaybackEventJs event) {
    _onPlatformEvent(event.toPlayEvent());
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
}
