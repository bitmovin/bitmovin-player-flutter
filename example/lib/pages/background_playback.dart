import 'package:audio_session/audio_session.dart';
import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player_example/controls.dart';
import 'package:bitmovin_player_example/env/env.dart';
import 'package:bitmovin_player_example/platform.dart';
import 'package:bitmovin_player_example/player_view_container.dart';
import 'package:flutter/material.dart';

/// This example showcases how to achieve background playback with the
/// Bitmovin Player using the `audio_session` package.
/// https://pub.dev/packages/audio_session

class BackgroundPlayback extends StatefulWidget {
  const BackgroundPlayback({super.key});
  static String routeName = 'BackgroundPlayback';

  @override
  State<BackgroundPlayback> createState() => _BackgroundPlaybackState();
}

class _BackgroundPlaybackState extends State<BackgroundPlayback> {
  final _sourceConfig = SourceConfig(
    url: isIOS
        ? 'https://cdn.bitmovin.com/content/internal/assets/MI201109210084/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8'
        : 'https://cdn.bitmovin.com/content/internal/assets/MI201109210084/mpds/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.mpd',
    type: isIOS ? SourceType.hls : SourceType.dash,
  );
  final _player = Player(
    config: const PlayerConfig(
      key: Env.bitmovinPlayerLicenseKey,
      playbackConfig: PlaybackConfig(
        isAutoplayEnabled: true,
        isBackgroundPlaybackEnabled: true,
      ),
      remoteControlConfig: RemoteControlConfig(isCastEnabled: false),
    ),
  );

  @override
  void initState() {
    setupAudioSession();

    _player.loadSourceConfig(_sourceConfig);
    super.initState();
  }

  Future<void> setupAudioSession() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
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
        title: const Text('Background Playback'),
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
