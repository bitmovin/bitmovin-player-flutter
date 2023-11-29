import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player_example/env/env.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class BasicPictureInPicture extends StatefulWidget {
  const BasicPictureInPicture({super.key});
  static String routeName = 'BasicPictureInPicture';

  @override
  State<BasicPictureInPicture> createState() => _BasicPictureInPictureState();
}

class _BasicPictureInPictureState extends State<BasicPictureInPicture> {
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
        title: const Text('Basic Picture-in-Picture'),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: PlayerView(
              player: _player,
              key: _playerViewKey,
              playerViewConfig: _playerViewConfig,
              onPictureInPictureEnter: (event) =>
                  _logger.d('received ${event.runtimeType}: ${event.toJson()}'),
              onPictureInPictureEntered: (event) =>
                  _logger.d('received ${event.runtimeType}: ${event.toJson()}'),
              onPictureInPictureExit: (event) =>
                  _logger.d('received ${event.runtimeType}: ${event.toJson()}'),
              onPictureInPictureExited: (event) =>
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
                    _playerViewKey.currentState?.enterPictureInPicture();
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
                    _playerViewKey.currentState?.exitPictureInPicture();
                  },
                  child: const Text('Exit PiP'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
