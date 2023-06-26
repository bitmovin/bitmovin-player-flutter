import 'dart:io';

import 'package:flutter/material.dart';
import 'package:player_example/controls.dart';

import 'package:bitmovin_player/player.dart';

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
  final _player = Player();

  String _toString(Map<String, dynamic> event) {
    return event.toString();
  }

  void _log(dynamic data) {
    debugPrint('=== LOG ===\nDATA ==> $data');
  }

  void listen() {
    _player.onError = (ErrorEvent data) {
      _log(data);
      setState(() {
        eventData = _toString(data.toJson());
      });
    };
    _player.onInfo = (InfoEvent data) {
      _log(data);
      setState(() {
        eventData = _toString(data.toJson());
      });
    };
    _player.onSourceLoad = (SourceLoadEvent data) {
      _log(data);
      setState(() {
        eventData = _toString(data.toJson());
      });
    };
    _player.onSourceLoaded = (SourceLoadedEvent data) {
      _log(data);
      setState(() {
        eventData = _toString(data.toJson());
      });
    };
    _player.onMuted = (MutedEvent data) {
      _log(data);
      setState(() {
        eventData = _toString(data.toJson());
      });
    };
    _player.onPaused = (PausedEvent data) {
      _log(data);
      setState(() {
        eventData = _toString(data.toJson());
      });
    };
    _player.onPlay = (PlayEvent data) {
      _log(data);
      setState(() {
        eventData = _toString(data.toJson());
      });
    };
    _player.onPlaybackFinished = (PlaybackFinishedEvent data) {
      _log(data);
      setState(() {
        eventData = _toString(data.toJson());
      });
    };
    _player.onPlaying = (PlayingEvent data) {
      _log(data);
      setState(() {
        eventData = _toString(data.toJson());
      });
    };
    _player.onReady = (ReadyEvent data) {
      _log(data);
      setState(() {
        eventData = _toString(data.toJson());
      });
    };
    _player.onSeek = (SeekEvent data) {
      _log(data);
      setState(() {
        eventData = _toString(data.toJson());
      });
    };
    _player.onSeeked = (SeekedEvent data) {
      _log(data);
      setState(() {
        eventData = _toString(data.toJson());
      });
    };
    _player.onSourceAdded = (SourceAddedEvent data) {
      _log(data);
      setState(() {
        eventData = _toString(data.toJson());
      });
    };
    _player.onSourceRemoved = (SourceRemovedEvent data) {
      _log(data);
      setState(() {
        eventData = _toString(data.toJson());
      });
    };
    _player.onSourceError = (SourceErrorEvent data) {
      _log(data);
      setState(() {
        eventData = _toString(data.toJson());
      });
    };
    _player.onSourceInfo = (SourceInfoEvent data) {
      _log(data);
      setState(() {
        eventData = _toString(data.toJson());
      });
    };
    _player.onSourceUnloaded = (SourceUnloadedEvent data) {
      _log(data);
      setState(() {
        eventData = _toString(data.toJson());
      });
    };
    _player.onSourceWarning = (SourceWarningEvent data) {
      _log(data);
      setState(() {
        eventData = _toString(data.toJson());
      });
    };
    _player.onTimeChanged = (TimeChangedEvent data) {
      _log(data);
      setState(() {
        eventData = _toString(data.toJson());
      });
    };
    _player.onUnmuted = (UnmutedEvent data) {
      _log(data);
      setState(() {
        eventData = _toString(data.toJson());
      });
    };
    _player.onWarning = (WarningEvent data) {
      _log(data);
      setState(() {
        eventData = _toString(data.toJson());
      });
    };
  }

  @override
  void initState() {
    listen();
    super.initState();
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
              _player.loadWithSourceConfig(sourceConfig);
            },
            onPlayPressed: () => _player.play(),
            onPausePressed: () => _player.pause(),
            onMutePressed: () => _player.mute(),
            onUnmutePressed: () => _player.unmute(),
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
