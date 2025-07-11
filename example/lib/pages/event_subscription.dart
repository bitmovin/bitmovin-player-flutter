import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player_example/controls.dart';
import 'package:bitmovin_player_example/env/env.dart';
import 'package:bitmovin_player_example/events.dart';
import 'package:bitmovin_player_example/platform.dart';
import 'package:bitmovin_player_example/player_info.dart';
import 'package:bitmovin_player_example/player_view_container.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class EventSubscription extends StatefulWidget {
  const EventSubscription({super.key});
  static String routeName = 'EventSubscription';

  @override
  State<EventSubscription> createState() => _EventSubscriptionState();
}

class _EventSubscriptionState extends State<EventSubscription> {
  final _eventsKey = GlobalKey<EventsState>();
  final _playerInfoKey = GlobalKey<PlayerInfoState>();
  final _sourceConfig = SourceConfig(
    url: isIOS
        ? 'https://cdn.bitmovin.com/content/internal/assets/MI201109210084/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8'
        : 'https://cdn.bitmovin.com/content/internal/assets/MI201109210084/mpds/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.mpd',
    type: isIOS ? SourceType.hls : SourceType.dash,
  );
  final _player = Player(
    config: const PlayerConfig(
      key: Env.bitmovinPlayerLicenseKey,
      remoteControlConfig: RemoteControlConfig(isCastEnabled: false),
    ),
  );
  final _logger = Logger();

  void _onEvent(Event event) {
    _playerInfoKey.currentState?.updatePlayerInfo(_player, event);

    final eventName = '${event.runtimeType}';
    final eventData = '$eventName ${event.toJson()}';
    _logger.d(eventData);
    _eventsKey.currentState?.add(eventName);
  }

  void _listen() {
    _player
      ..onError = _onEvent
      ..onInfo = _onEvent
      ..onSourceLoad = _onEvent
      ..onSourceLoaded = _onEvent
      ..onMuted = _onEvent
      ..onPaused = _onEvent
      ..onPlay = _onEvent
      ..onPlaybackFinished = _onEvent
      ..onPlaying = _onEvent
      ..onReady = _onEvent
      ..onSeek = _onEvent
      ..onSeeked = _onEvent
      ..onSourceAdded = _onEvent
      ..onSourceRemoved = _onEvent
      ..onSourceError = _onEvent
      ..onSourceInfo = _onEvent
      ..onSourceUnloaded = _onEvent
      ..onSourceWarning = _onEvent
      ..onTimeChanged = _onEvent
      ..onUnmuted = _onEvent
      ..onWarning = _onEvent
      ..onSubtitleAdded = _onEvent
      ..onSubtitleRemoved = _onEvent
      ..onSubtitleChanged = _onEvent
      ..onCueEnter = _onEvent
      ..onCueExit = _onEvent
      ..onAirPlayAvailable = _onEvent
      ..onAirPlayChanged = _onEvent;
  }

  @override
  void initState() {
    _listen();
    _player.loadSourceConfig(_sourceConfig);
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Subscription'),
      ),
      body: Column(
        children: [
          PlayerViewContainer(player: _player),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Controls(
              onLoadPressed: () => _player.loadSourceConfig(_sourceConfig),
              onPlayPressed: _player.play,
              onPausePressed: _player.pause,
              onMutePressed: _player.mute,
              onUnmutePressed: _player.unmute,
              onSkipForwardPressed: () async =>
                  _player.seek(await _player.currentTime + 10),
              onSkipBackwardPressed: () async =>
                  _player.seek(await _player.currentTime - 10),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Events(key: _eventsKey),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: PlayerInfo(key: _playerInfoKey),
            ),
          ),
        ],
      ),
    );
  }
}
