import 'package:bitmovin_sdk/player.dart';

class SharedEventListener {
  final Player player;
  final Function(dynamic data) callback;
  SharedEventListener(this.player, this.callback) {
    player.onError = callback;
    player.onInfo = callback;
    player.onLoad = callback;
    player.onLoaded = callback;
    player.onMuted = callback;
    player.onPaused = callback;
    player.onPlay = callback;
    player.onPlaybackFinished = callback;
    player.onPlaying = callback;
    player.onReady = callback;
    player.onSeek = callback;
    player.onSeeked = callback;
    player.onSourceAdded = callback;
    player.onSourceRemoved = callback;
    player.onSourceError = callback;
    player.onSourceInfo = callback;
    player.onSourceUnLoaded = callback;
    player.onSourceWarning = callback;
    player.onTimeChanged = callback;
    player.onUnMuted = callback;
    player.onWarning = callback;
  }
}
