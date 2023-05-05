import 'dart:io';

import 'package:bitmovin_sdk/player.dart';
import 'package:flutter/material.dart';
import 'package:player_example/controls.dart';

class PlaybackWithConfig extends StatefulWidget {
  const PlaybackWithConfig({super.key});

  @override
  State<PlaybackWithConfig> createState() => PlaybackWithConfigState();
}

class PlaybackWithConfigState extends State<PlaybackWithConfig> {
  String eventData = '';
  final sourceConfig = SourceConfig(
    url: Platform.isAndroid
        ? 'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/mpds/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.mpd'
        : 'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8',
    type: Platform.isAndroid ? SourceType.dash : SourceType.hls,
  );
  final _player = Player(
    const PlayerConfig(
      playbackConfig: PlaybackConfig(
        isAutoplayEnabled: true,
        isMuted: true,
      ),
    ),
  );

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
