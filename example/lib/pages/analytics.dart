import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player_example/controls.dart';
import 'package:bitmovin_player_example/env/env.dart';
import 'package:bitmovin_player_example/platform.dart';
import 'package:bitmovin_player_example/player_view_container.dart';
import 'package:flutter/material.dart';

class PlayerAnalytics extends StatefulWidget {
  const PlayerAnalytics({super.key});
  static String routeName = 'Collecting Analytics';

  @override
  State<PlayerAnalytics> createState() => _PlayerAnalyticsState();
}

class _PlayerAnalyticsState extends State<PlayerAnalytics> {
  final _sourceConfig = SourceConfig(
    url: isIOS
        ? 'https://cdn.bitmovin.com/content/internal/assets/MI201109210084/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8'
        : 'https://cdn.bitmovin.com/content/internal/assets/MI201109210084/mpds/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.mpd',
    type: isIOS ? SourceType.hls : SourceType.dash,
    analyticsSourceMetadata: const SourceMetadata(
      title: 'Collecting SourceMetadata Title',
      customData:
          CustomData(customData1: 'Collecting SourceMetadata customData1'),
    ),
  );
  final _player = Player(
    config: PlayerConfig(
      key: Env.bitmovinPlayerLicenseKey,
      playbackConfig: const PlaybackConfig(
        isAutoplayEnabled: true,
      ),
      remoteControlConfig: const RemoteControlConfig(isCastEnabled: false),
      analyticsConfig: Env.bitmovinAnalyticsLicenseKey != null
          ? AnalyticsConfig(licenseKey: Env.bitmovinAnalyticsLicenseKey!)
          : null,
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
        title: const Text('Collecting Analytics'),
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
          OutlinedButton(
            onPressed: () {
              _player.analytics.sendCustomDataEvent(
                const CustomData(customData5: 'Button Clicked'),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sent custom data'),
                ),
              );
            },
            child: const Text('Send custom data'),
          ),
        ],
      ),
    );
  }
}
