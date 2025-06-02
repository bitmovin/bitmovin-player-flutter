import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player_example/env/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class FullscreenHandling extends StatefulWidget {
  const FullscreenHandling({super.key});
  static String routeName = 'FullscreenHandling';

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
  final _sourceConfig = const SourceConfig(
    url:
        'https://cdn.bitmovin.com/content/internal/assets/MI201109210084/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8',
    type: SourceType.hls,
  );
  final _player = Player(
    config: const PlayerConfig(
      key: Env.bitmovinPlayerLicenseKey,
      remoteControlConfig: RemoteControlConfig(isCastEnabled: false),
    ),
  );
  final _fullscreenHandler = ExampleFullscreenHandler();
  final _logger = Logger();

  @override
  void initState() {
    _fullscreenHandler.onStateChange = _refresh;
    _player.loadSourceConfig(_sourceConfig);
    super.initState();
  }

  void _refresh() {
    setState(() {});
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
          AspectRatio(
            aspectRatio: 16 / 9,
            child: PlayerView(
              player: _player,
              key: _playerViewKey,
              fullscreenHandler: _fullscreenHandler,
              onFullscreenEnter: (event) =>
                  _logger.d('received ${event.runtimeType}: ${event.toJson()}'),
              onFullscreenExit: (event) =>
                  _logger.d('received ${event.runtimeType}: ${event.toJson()}'),
            ),
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
                    _playerViewKey.currentState?.enterFullscreen();
                  },
                  child: const Text('Enter Fullscreen'),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue),
                  ),
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
