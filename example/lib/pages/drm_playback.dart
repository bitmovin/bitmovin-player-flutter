import 'dart:io';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player_example/controls.dart';
import 'package:bitmovin_player_example/env/env.dart';
import 'package:bitmovin_player_example/events.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class DrmPlayback extends StatefulWidget {
  static String routeName = 'DrmPlayback';
  const DrmPlayback({super.key});

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
    ),
  );
  final _logger = Logger();

  void _onEvent(Event event) {
    final eventName = "${event.runtimeType}";
    final eventData = "$eventName ${event.toJson()}";
    _logger.d(eventData);
    _eventsKey.currentState?.add(eventName);
  }

  void _listen() {
    _player.onSourceLoaded = (SourceLoadedEvent data) {
      _onEvent(data);
    };
    _player.onPlay = (PlayEvent data) {
      _onEvent(data);
    };
    _player.onPaused = (PausedEvent data) {
      _onEvent(data);
    };
    _player.onPlaying = (PlayingEvent data) {
      _onEvent(data);
    };
    _player.onReady = (ReadyEvent data) {
      _onEvent(data);
    };
    _player.onSeek = (SeekEvent data) {
      _onEvent(data);
    };
    _player.onSeeked = (SeekedEvent data) {
      _onEvent(data);
    };
    _player.onMuted = (MutedEvent data) {
      _onEvent(data);
    };
    _player.onUnmuted = (UnmutedEvent data) {
      _onEvent(data);
    };
  }

  @override
  void initState() {
    _listen();
    _player.loadSourceConfig(_sourceConfig);
    super.initState();
  }

  @override
  setState(fn) {
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
