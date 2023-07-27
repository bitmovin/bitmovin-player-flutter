import 'dart:io';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player_example/controls.dart';
import 'package:bitmovin_player_example/env/env.dart';
import 'package:bitmovin_player_example/events.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class EventSubscription extends StatefulWidget {
  static String routeName = 'EventSubscription';
  const EventSubscription({super.key});

  @override
  State<EventSubscription> createState() => _EventSubscriptionState();
}

class _EventSubscriptionState extends State<EventSubscription> {
  List<String> events = [];
  final GlobalKey<EventsState> eventsKey = GlobalKey<EventsState>();

  final sourceConfig = SourceConfig(
    url: Platform.isAndroid
        ? 'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/mpds/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.mpd'
        : 'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8',
    type: Platform.isAndroid ? SourceType.dash : SourceType.hls,
  );
  final _player = Player(
    config: const PlayerConfig(
      key: Env.bitmovinPlayerLicenseKey,
    ),
  );
  final _logger = Logger();

  void _onEvent(Event event) {
    final eventName = "${event.runtimeType}";
    final eventData = "$eventName ${event.toJson()}";
    _logger.d(eventData);
    eventsKey.currentState?.add(eventName);
  }

  void listen() {
    _player.onError = (ErrorEvent data) {
      _onEvent(data);
    };
    _player.onInfo = (InfoEvent data) {
      _onEvent(data);
    };
    _player.onSourceLoad = (SourceLoadEvent data) {
      _onEvent(data);
    };
    _player.onSourceLoaded = (SourceLoadedEvent data) {
      _onEvent(data);
    };
    _player.onMuted = (MutedEvent data) {
      _onEvent(data);
    };
    _player.onPaused = (PausedEvent data) {
      _onEvent(data);
    };
    _player.onPlay = (PlayEvent data) {
      _onEvent(data);
    };
    _player.onPlaybackFinished = (PlaybackFinishedEvent data) {
      _onEvent(data);
    };
    _player.onPlaying = (PlayingEvent data) {
      _onEvent(data);
    };
    _player.onReady = (ReadyEvent data) {
      _onEvent(data);
    };
    _player.onSeek = (SeekEvent data) {
      _onEvent(data);
    };
    _player.onSeeked = (SeekedEvent data) {
      _onEvent(data);
    };
    _player.onSourceAdded = (SourceAddedEvent data) {
      _onEvent(data);
    };
    _player.onSourceRemoved = (SourceRemovedEvent data) {
      _onEvent(data);
    };
    _player.onSourceError = (SourceErrorEvent data) {
      _onEvent(data);
    };
    _player.onSourceInfo = (SourceInfoEvent data) {
      _onEvent(data);
    };
    _player.onSourceUnloaded = (SourceUnloadedEvent data) {
      _onEvent(data);
    };
    _player.onSourceWarning = (SourceWarningEvent data) {
      _onEvent(data);
    };
    _player.onTimeChanged = (TimeChangedEvent data) {
      _onEvent(data);
    };
    _player.onUnmuted = (UnmutedEvent data) {
      _onEvent(data);
    };
    _player.onWarning = (WarningEvent data) {
      _onEvent(data);
    };
  }

  @override
  void initState() {
    listen();
    _player.loadSourceConfig(sourceConfig);
    super.initState();
  }

  @override
  void setState(fn) {
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
          SizedBox.fromSize(
            size: const Size.fromHeight(226),
            child: PlayerView(
              player: _player,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Controls(
              onLoadPressed: () {
                _player.loadSourceConfig(sourceConfig);
              },
              onPlayPressed: () => _player.play(),
              onPausePressed: () => _player.pause(),
              onMutePressed: () => _player.mute(),
              onUnmutePressed: () => _player.unmute(),
              onSkipForwardPressed: () async =>
                  _player.seek(await _player.currentTime + 10),
              onSkipBackwardPressed: () async =>
                  _player.seek(await _player.currentTime - 10),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 40),
              child: Events(key: eventsKey),
            ),
          ),
        ],
      ),
    );
  }
}
