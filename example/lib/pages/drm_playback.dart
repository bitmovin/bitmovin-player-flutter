import 'dart:io';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player_example/controls.dart';
import 'package:bitmovin_player_example/env/env.dart';
import 'package:bitmovin_player_example/events.dart';
import 'package:bitmovin_player_example/player_view_container.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class DrmPlayback extends StatefulWidget {
  const DrmPlayback({super.key});
  static String routeName = 'DrmPlayback';

  @override
  State<DrmPlayback> createState() => _DrmPlaybackState();
}

class _DrmPlaybackState extends State<DrmPlayback> {
  final GlobalKey<EventsState> _eventsKey = GlobalKey<EventsState>();
  final _sourceConfig = SourceConfig(
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
  final _player = Player(
    config: const PlayerConfig(
      key: Env.bitmovinPlayerLicenseKey,
      remoteControlConfig: RemoteControlConfig(isCastEnabled: false),
    ),
  );
  final _logger = Logger();

  void _onEvent(Event event) {
    final eventName = '${event.runtimeType}';
    final eventData = '$eventName ${event.toJson()}';
    _logger.d(eventData);
    _eventsKey.currentState?.add(eventName);
  }

  void _listen() {
    _player
      ..onSourceLoaded = _onEvent
      ..onPlay = _onEvent
      ..onPaused = _onEvent
      ..onPlaying = _onEvent
      ..onReady = _onEvent
      ..onSeek = _onEvent
      ..onSeeked = _onEvent
      ..onMuted = _onEvent
      ..onUnmuted = _onEvent;
  }

  @override
  void initState() {
    _listen();
    _player.loadSourceConfig(_sourceConfig);
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
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
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 40),
              child: Events(key: _eventsKey),
            ),
          ),
        ],
      ),
    );
  }
}
