import 'dart:io';

import 'package:bitmovin_sdk/player.dart';
import 'package:flutter/material.dart';
import 'package:player_example/controls.dart';

class BasicPlayback extends StatefulWidget {
  static String routeName = 'BasicPlayback';
  const BasicPlayback({super.key});

  @override
  State<BasicPlayback> createState() => _BasicPlaybackState();
}

class _BasicPlaybackState extends State<BasicPlayback> {
  String _player1Event = '';
  final sourceConfig = SourceConfig(
    url: Platform.isAndroid
        ? 'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/mpds/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.mpd'
        : 'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8',
    type: Platform.isAndroid ? SourceType.dash : SourceType.hls,
  );
  final _player1 = Player();

  String _toString(Map<String, dynamic> event) {
    return event.toString();
  }

  void listen() {
    _player1.onLoad = (data) {
      setState(() {
        _player1Event = _toString(data);
      });
    };
    _player1.onLoaded = (data) {
      setState(() {
        _player1Event = _toString(data);
      });
    };
    _player1.onTimeChanged = (data) {
      setState(() {
        _player1Event = _toString(data);
      });
    };
    _player1.onPlay = (data) {
      setState(() {
        _player1Event = _toString(data);
      });
    };
    _player1.onPlaying = (data) {
      setState(() {
        _player1Event = _toString(data);
      });
    };
    _player1.onPaused = (data) {
      setState(() {
        _player1Event = _toString(data);
      });
    };
    _player1.onMuted = (data) {
      setState(() {
        _player1Event = _toString(data);
      });
    };
    _player1.onUnMuted = (data) {
      setState(() {
        _player1Event = _toString(data);
      });
    };
    _player1.onSourceAdded = (data) {
      setState(() {
        _player1Event = _toString(data);
      });
    };
    _player1.onSourceRemoved = (data) {
      setState(() {
        _player1Event = _toString(data);
      });
    };
    _player1.onSeeked = (data) {
      setState(() {
        _player1Event = _toString(data);
      });
    };
    _player1.onSeek = (data) {
      setState(() {
        _player1Event = _toString(data);
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
    _player1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Playback'),
      ),
      body: Column(
        children: [
          Controls(
            onLoadPressed: () {
              _player1.loadWithSourceConfig(sourceConfig);
            },
            onPlayPressed: () => _player1.play(),
            onPausePressed: () => _player1.pause(),
            onMutePressed: () => _player1.mute(),
            onUnmutePressed: () => _player1.unmute(),
          ),
          SizedBox.fromSize(
            size: const Size.fromHeight(180),
            child: PlayerView(
              player: _player1,
            ),
          ),
          Text(_player1Event),
        ],
      ),
    );
  }
}
