import 'dart:io';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player_example/controls.dart';
import 'package:bitmovin_player_example/env/env.dart';
import 'package:flutter/material.dart';

class AnalyticsExample extends StatefulWidget {
  static String routeName = 'Collecting Analytics';

  const AnalyticsExample({super.key});

  @override
  State<AnalyticsExample> createState() => _AnalyticsExampleState();
}

class _AnalyticsExampleState extends State<AnalyticsExample> {
  final _sourceConfig = SourceConfig(
      url: Platform.isAndroid
          ? 'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/mpds/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.mpd'
          : 'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8',
      type: Platform.isAndroid ? SourceType.dash : SourceType.hls,
      sourceMetadata: const SourceMetadata(
        title: "Collecting SourceMetadata Title",
        customData:
            CustomData(customData1: "Collecting SourceMetadata customData1"),
      ));
  final _player = Player(
    config: const PlayerConfig(
        key: Env.bitmovinPlayerLicenseKey,
        playbackConfig: PlaybackConfig(
          isAutoplayEnabled: true,
          isMuted: false,
        ),
        analyticsConfig:
            AnalyticsConfig(licenseKey: Env.bitmovinAnalyticsLicenseKey)),
  );

  @override
  void initState() {
    _player.loadSourceConfig(_sourceConfig);
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
        title: const Text('Collecting Analytics'),
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
              onLoadPressed: () => _player.loadSourceConfig(_sourceConfig),
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
          OutlinedButton(
            onPressed: () {
              _player.sendCustomDataEvent(
                  const CustomData(customData5: "Button Clicked"));
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Sent custom data"),
              ));
            },
            child: const Text('Send CustomData Event'),
          ),
        ],
      ),
    );
  }
}
