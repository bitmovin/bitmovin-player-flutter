import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player_example/controls.dart';
import 'package:bitmovin_player_example/env/env.dart';
import 'package:bitmovin_player_example/platform.dart';
import 'package:flutter/material.dart';

class AudioOnly extends StatefulWidget {
  const AudioOnly({super.key});
  static String routeName = 'AudioOnly';

  @override
  State<AudioOnly> createState() => _AudioOnlyState();
}

class _AudioOnlyState extends State<AudioOnly> {
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
        title: const Text('Audio Only'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Controls(
              onLoadPressed: () => _player.loadSourceConfig(_sourceConfig),
              onUnloadPressed: _player.unload,
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
