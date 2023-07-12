import 'dart:io';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player_example/controls.dart';
import 'package:bitmovin_player_example/env/env.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class BasicPlaybackWithEventSubscription extends StatefulWidget {
  static String routeName = 'BasicPlaybackWithEventSubscription';
  const BasicPlaybackWithEventSubscription({super.key});

  @override
  State<BasicPlaybackWithEventSubscription> createState() =>
      _BasicPlaybackWithEventSubscriptionState();
}

class _BasicPlaybackWithEventSubscriptionState
    extends State<BasicPlaybackWithEventSubscription> {
  String eventData = '';
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
    String eventString = "${event.runtimeType} ${event.toJson()}";

    _logger.d(eventString);
    setState(() {
      eventData = eventString;
    });
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
        title: const Text('Basic Playback'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Controls(
            onLoadPressed: () {
              _player.loadSourceConfig(sourceConfig);
            },
            onPlayPressed: () => _player.play(),
            onPausePressed: () => _player.pause(),
            onMutePressed: () => _player.mute(),
            onUnmutePressed: () => _player.unmute(),
            onSkipForwardPressed: () async =>
                _player.seek(await _player.currentTime + 10),
          ),
          SizedBox.fromSize(
            size: const Size.fromHeight(226),
            child: PlayerView(
              player: _player,
            ),
          ),
          Text(eventData),
        ],
      ),
    );
  }
}
