import 'dart:io';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player_example/env/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FullscreenHandling extends StatefulWidget {
  static String routeName = 'FullscreenHandling';
  const FullscreenHandling({super.key});

  @override
  State<FullscreenHandling> createState() => _FullscreenHandlingState();
}

class ExampleFullscreenHandler implements FullscreenHandler {
  @override
  bool get isFullscreen => _isFullscreen;
  bool _isFullscreen = false;
  void Function()? onStateChange;

  @override
  void enterFullscreen() {
    _isFullscreen = true;

    // Hide status/navigation bar
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
      overlays: [],
    );

    onStateChange?.call();
  }

  @override
  void exitFullscreen() {
    _isFullscreen = false;

    // Show status/navigation bar
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );

    onStateChange?.call();
  }
}

class _FullscreenHandlingState extends State<FullscreenHandling> {
  final _playerViewKey = GlobalKey<PlayerViewState>();
  final _sourceConfig = SourceConfig(
    url: Platform.isAndroid
        ? 'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/mpds/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.mpd'
        : 'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8',
    type: Platform.isAndroid ? SourceType.dash : SourceType.hls,
  );
  final _player = Player(
    config: const PlayerConfig(
        key: Env.bitmovinPlayerLicenseKey,
        playbackConfig: PlaybackConfig(
          isAutoplayEnabled: true,
          isMuted: false,
        )),
  );
  final _fullscreenHandler = ExampleFullscreenHandler();

  @override
  void initState() {
    _fullscreenHandler.onStateChange = () {
      refresh();
    };
    _player.loadSourceConfig(_sourceConfig);
    super.initState();
  }

  void refresh() {
    setState(() {});
  }

  @override
  void setState(fn) {
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
      appBar: _fullscreenHandler.isFullscreen
          ? null
          : AppBar(
              title: const Text('Fullscreen Handling'),
            ),
      backgroundColor:
          _fullscreenHandler.isFullscreen ? Colors.black : Colors.white,
      body: Column(
        mainAxisAlignment: _fullscreenHandler.isFullscreen
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          SizedBox.fromSize(
            size: const Size.fromHeight(226),
            child: PlayerView(
              player: _player,
              key: _playerViewKey,
              fullscreenHandler: _fullscreenHandler,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 5),
                child: OutlinedButton(
                  onPressed: () {
                    _playerViewKey.currentState?.enterFullscreen();
                  },
                  child: const Text('Enter Fullscreen'),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                child: OutlinedButton(
                  onPressed: () {
                    _playerViewKey.currentState?.exitFullscreen();
                  },
                  child: const Text('Exit Fullscreen'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
