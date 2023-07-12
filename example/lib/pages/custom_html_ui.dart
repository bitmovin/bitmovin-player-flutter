import 'dart:io';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player_example/controls.dart';
import 'package:bitmovin_player_example/env/env.dart';
import 'package:flutter/material.dart';

class CustomHtmlUi extends StatefulWidget {
  static String routeName = 'CustomHtmlUi';
  const CustomHtmlUi({super.key});

  @override
  State<CustomHtmlUi> createState() => _CustomHtmlUiState();
}

class _CustomHtmlUiState extends State<CustomHtmlUi> {
  final sourceConfig = SourceConfig(
    url: Platform.isAndroid
        ? 'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/mpds/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.mpd'
        : 'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8',
    type: Platform.isAndroid ? SourceType.dash : SourceType.hls,
  );
  final _player = Player(
    config: const PlayerConfig(
        key: Env.bitmovinPlayerLicenseKey,
        styleConfig: StyleConfig(
          playerUiCss:
              'https://cdn.statically.io/gh/bitmovin/bitmovin-player-ios-samples/main/CustomHtmlUi/Supporting%20Files/bitmovinplayer-ui.min.css',
          playerUiJs:
              'https://cdn.statically.io/gh/bitmovin/bitmovin-player-ios-samples/main/CustomHtmlUi/Supporting%20Files/bitmovinplayer-ui.min.js',
          supplementalPlayerUiCss:
              'https://cdn.bitmovin.com/player/ui/ui-customized-sample.css',
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
        title: const Text('Custom HTML UI'),
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
        ],
      ),
    );
  }
}
