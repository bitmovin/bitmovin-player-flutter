import 'dart:io';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player_example/controls.dart';
import 'package:bitmovin_player_example/env/env.dart';
import 'package:flutter/material.dart';

class BasicPlayback extends StatefulWidget {
  static String routeName = 'BasicPlayback';
  const BasicPlayback({super.key});

  @override
  State<BasicPlayback> createState() => _BasicPlaybackState();
}

class _BasicPlaybackState extends State<BasicPlayback> {
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
        playbackConfig: PlaybackConfig(
          isAutoplayEnabled: true,
          isMuted: false,
        )),
  );

  @override
  void initState() {
    _player.loadSourceConfig(sourceConfig);
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
              _player.loadSourceConfig(sourceConfig);
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
