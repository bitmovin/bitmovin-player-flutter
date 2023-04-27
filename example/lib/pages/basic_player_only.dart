import 'dart:io';

import 'package:bitmovin_sdk/player.dart';
import 'package:flutter/material.dart';
import 'package:player_example/controls.dart';

class BasicPlayerOnly extends StatefulWidget {
  static String routeName = 'BasicPlayerOnly';

  const BasicPlayerOnly({super.key});

  @override
  State<BasicPlayerOnly> createState() => _BasicPlayerOnlyState();
}

class _BasicPlayerOnlyState extends State<BasicPlayerOnly> {
  final sourceConfig = SourceConfig(
    url: Platform.isAndroid
        ? 'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/mpds/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.mpd'
        : 'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8',
    type: Platform.isAndroid ? SourceType.dash : SourceType.hls,
  );

  final _player2 = Player();

  String eventData = "";

  String _toString(Map<String, dynamic> event) {
    return event.toString();
  }

  void listener() {
    _player2.onReady = (data) {
      setState(() {
        eventData = _toString(data);
      });
    };
    _player2.onLoad = (data) {
      setState(() {
        eventData = _toString(data);
      });
    };
    _player2.onLoaded = (data) {
      setState(() {
        eventData = _toString(data);
      });
    };
    _player2.onSourceAdded = (data) {
      setState(() {
        eventData = _toString(data);
      });
    };
    _player2.onSourceError = (data) {
      setState(() {
        eventData = _toString(data);
      });
    };
    _player2.onSourceWarning = (data) {
      setState(() {
        eventData = _toString(data);
      });
    };
    _player2.onPlaybackFinished = (data) {
      setState(() {
        eventData = _toString(data);
      });
    };
    _player2.onError = (data) {
      setState(() {
        eventData = _toString(data);
      });
    };
    _player2.onInfo = (data) {
      setState(() {
        eventData = _toString(data);
      });
    };
    _player2.onUnMuted = (data) {
      setState(() {
        eventData = _toString(data);
      });
    };
    _player2.onMuted = (data) {
      setState(() {
        eventData = _toString(data);
      });
    };
    _player2.onWarning = (data) {
      setState(() {
        eventData = _toString(data);
      });
    };
    _player2.onTimeChanged = (data) {
      setState(() {
        eventData = _toString(data);
      });
    };
    _player2.onPaused = (data) {
      setState(() {
        eventData = _toString(data);
      });
    };
  }

  @override
  void dispose() {
    _player2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    listener();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Playback Audio only'),
      ),
      body: Column(
        children: [
          const Text(
            'PLAYER ONLY',
            style: TextStyle(
              fontSize: 32,
            ),
          ),
          Controls(
            onLoadPressed: () {
              _player2.loadWithSourceConfig(sourceConfig);
            },
            onPlayPressed: () => _player2.play(),
            onPausePressed: () => _player2.pause(),
            onMutePressed: () => _player2.mute(),
            onUnmutePressed: () => _player2.unmute(),
          ),
          Text(eventData)
        ],
      ),
    );
  }
}
