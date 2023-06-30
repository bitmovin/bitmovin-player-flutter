import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bitmovin_player_example/controls.dart';

import 'package:bitmovin_player/bitmovin_player.dart';

class DrmPlayback extends StatefulWidget {
  static String routeName = 'DrmPlayback';
  const DrmPlayback({super.key});

  @override
  State<DrmPlayback> createState() => _DrmPlaybackState();
}

class _DrmPlaybackState extends State<DrmPlayback> {
  String eventData = '';
  final sourceConfig = SourceConfig(
    url: Platform.isAndroid
        ? 'https://bitmovin-a.akamaihd.net/content/art-of-motion_drm/mpds/11331.mpd'
        : 'https://fps.ezdrm.com/demo/video/ezdrm.m3u8',
    type: Platform.isAndroid ? SourceType.dash : SourceType.hls,
    drmConfig: DrmConfig(
      fairplay: FairplayConfig(
        licenseUrl:
            'https://fps.ezdrm.com/api/licenses/09cc0377-6dd4-40cb-b09d-b582236e70fe',
        certificateUrl: 'https://fps.ezdrm.com/demo/video/eleisure.cer',
        prepareMessage: (spcData, _) => spcData,
      ),
      widevine: WidevineConfig(
        licenseUrl: 'https://cwip-shaka-proxy.appspot.com/no_auth',
        prepareMessage: (keyMessage) => keyMessage,
        prepareLicense: (licenseResponse) => licenseResponse,
        preferredSecurityLevel: 'L3',
        shouldKeepDrmSessionsAlive: true,
        httpHeaders: const {
          'test-header': 'test header value',
          'different-header': 'different value',
        },
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
        title: const Text('DRM Playback'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Controls(
            onLoadPressed: () => _player.loadSourceConfig(sourceConfig),
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
