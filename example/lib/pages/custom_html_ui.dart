import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player_example/controls.dart';
import 'package:bitmovin_player_example/env/env.dart';
import 'package:bitmovin_player_example/platform.dart';
import 'package:bitmovin_player_example/player_view_container.dart';
import 'package:flutter/material.dart';

class CustomHtmlUi extends StatefulWidget {
  const CustomHtmlUi({super.key});
  static String routeName = 'CustomHtmlUi';

  @override
  State<CustomHtmlUi> createState() => _CustomHtmlUiState();
}

class _CustomHtmlUiState extends State<CustomHtmlUi> {
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
      styleConfig: StyleConfig(
        playerUiCss:
            'https://cdn.statically.io/gh/bitmovin/bitmovin-player-ios-samples/main/CustomHtmlUi/Supporting%20Files/bitmovinplayer-ui.min.css',
        playerUiJs:
            'https://cdn.statically.io/gh/bitmovin/bitmovin-player-ios-samples/main/CustomHtmlUi/Supporting%20Files/bitmovinplayer-ui.min.js',
        supplementalPlayerUiCss:
            'https://cdn.bitmovin.com/player/ui/ui-customized-sample.css',
      ),
    ),
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
        title: const Text('Custom HTML UI'),
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
        ],
      ),
    );
  }
}
