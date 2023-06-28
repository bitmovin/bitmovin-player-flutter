import 'dart:io';

import 'package:bitmovin_player/player.dart';
import 'package:flutter/material.dart';
import 'package:bitmovin_player_example/controls.dart';

class LicenseKeyViaConfig extends StatefulWidget {
  static String routeName = 'LicenseKeyViaConfig';
  const LicenseKeyViaConfig({super.key});

  @override
  State<LicenseKeyViaConfig> createState() => _LicenseKeyViaConfigState();
}

class _LicenseKeyViaConfigState extends State<LicenseKeyViaConfig> {
  final sourceConfig = SourceConfig(
    url: Platform.isAndroid
        ? 'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/mpds/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.mpd'
        : 'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8',
    type: Platform.isAndroid ? SourceType.dash : SourceType.hls,
  );

  final _player = Player(
    const PlayerConfig(
      key: '***REMOVED***',
    ),
  );

  String eventData = "";

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Playback Audio Only'),
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
          SingleChildScrollView(
            child: Text(eventData),
          ),
        ],
      ),
    );
  }
}
