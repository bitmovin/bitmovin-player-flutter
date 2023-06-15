import 'package:flutter/material.dart';
import 'package:player_example/controls.dart';

import 'package:bitmovin_sdk/player.dart';

class DrmPlayback extends StatefulWidget {
  static String routeName = 'DrmPlayback';
  const DrmPlayback({super.key});

  @override
  State<DrmPlayback> createState() => _DrmPlaybackState();
}

class _DrmPlaybackState extends State<DrmPlayback> {
  String eventData = '';
  final sourceConfig = const SourceConfig(
    url: 'https://fps.ezdrm.com/demo/video/ezdrm.m3u8',
    type: SourceType.hls,
    drmConfig: DrmConfig(
      fairplay: FairplayConfig(
        licenseUrl:
            'https://fps.ezdrm.com/api/licenses/09cc0377-6dd4-40cb-b09d-b582236e70fe',
        certificateUrl: 'https://fps.ezdrm.com/demo/video/eleisure.cer',
      ),
    ),
  );
  final _player = Player();

  void _log(dynamic data) {
    debugPrint('=== LOG ===\nDATA ==> $data');
  }

  void _onEvent(Map<String, dynamic> eventJson) {
    String eventString = eventJson.toString();

    _log(eventString);
    setState(() {
      eventData = eventString;
    });
  }

  void listen() {
    _player.onSourceLoaded = (SourceLoadedEvent data) {
      _onEvent(data.toJson());
    };
    _player.onPlay = (PlayEvent data) {
      _onEvent(data.toJson());
    };
    _player.onPaused = (PausedEvent data) {
      _onEvent(data.toJson());
    };
    _player.onPlaying = (PlayingEvent data) {
      _onEvent(data.toJson());
    };
    _player.onReady = (ReadyEvent data) {
      _onEvent(data.toJson());
    };
    _player.onSeek = (SeekEvent data) {
      _onEvent(data.toJson());
    };
    _player.onSeeked = (SeekedEvent data) {
      _onEvent(data.toJson());
    };
    _player.onMuted = (MutedEvent data) {
      _onEvent(data.toJson());
    };
    _player.onUnmuted = (UnmutedEvent data) {
      _onEvent(data.toJson());
    };
  }

  @override
  void initState() {
    listen();
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
        title: const Text('DRM Playback'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Controls(
            onLoadPressed: () => _player.loadWithSourceConfig(sourceConfig),
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
