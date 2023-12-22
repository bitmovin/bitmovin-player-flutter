import 'dart:io' show Platform;

import 'package:audio_session/audio_session.dart';
import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player_example/env/env.dart';
import 'package:bitmovin_player_example/events.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class PictureInPicture extends StatefulWidget {
  const PictureInPicture({super.key});

  static String routeName = 'PictureInPicture';

  @override
  State<PictureInPicture> createState() => _PictureInPictureState();
}

class _PictureInPictureState extends State<PictureInPicture> {
  final _playerViewKey = GlobalKey<PlayerViewState>();
  final _sourceConfig = const SourceConfig(
    url:
        'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8',
    type: SourceType.hls,
  );
  final _player = Player(
    config: const PlayerConfig(
      key: Env.bitmovinPlayerLicenseKey,
      remoteControlConfig: RemoteControlConfig(isCastEnabled: false),
    ),
  );
  final _logger = Logger();
  final _playerViewConfig = const PlayerViewConfig(
    pictureInPictureConfig: PictureInPictureConfig(
      isEnabled: true,
      shouldEnterOnBackground: true,
    ),
  );
  final _eventsKey = GlobalKey<EventsState>();
  bool _isInPictureInPicture = false;

  void _onPictureInPictureEnterEvent(Event event) {
    _onEvent(event);
    setState(() {
      _isInPictureInPicture = true;
    });
  }

  void _onPictureInPictureExitEvent(Event event) {
    _onEvent(event);
    setState(() {
      _isInPictureInPicture = false;
    });
  }

  void _onEvent(Event event) {
    final eventName = '${event.runtimeType}';
    final eventData = '$eventName ${event.toJson()}';
    _logger.d(eventData);
    _eventsKey.currentState?.add(eventName);
  }

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

  // Since PiP on Android is basically just the whole activity fitted in a small
  // floating window, we don't want to display the whole scaffold
  bool get renderOnlyPlayerView => Platform.isAndroid && _isInPictureInPicture;

  @override
  Widget build(BuildContext context) {
    final playerView = PlayerView(
      player: _player,
      key: _playerViewKey,
      playerViewConfig: _playerViewConfig,
      onPictureInPictureEnter: _onPictureInPictureEnterEvent,
      onPictureInPictureEntered: _onEvent,
      onPictureInPictureExit: _onPictureInPictureExitEvent,
      onPictureInPictureExited: _onEvent,
    );
    if (renderOnlyPlayerView) {
      return playerView;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Picture-in-Picture'),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: playerView,
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 5),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue),
                  ),
                  onPressed: () {
                    _playerViewKey.currentState?.pictureInPicture
                        .enterPictureInPicture();
                  },
                  child: const Text('Enter PiP'),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue),
                  ),
                  onPressed: () {
                    _playerViewKey.currentState?.pictureInPicture
                        .exitPictureInPicture();
                  },
                  child: const Text('Exit PiP'),
                ),
              ),
            ],
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
