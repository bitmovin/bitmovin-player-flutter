import 'package:audio_session/audio_session.dart';
import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player_example/env/env.dart';
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

  void _onEvent(Event event) {
    final eventName = '${event.runtimeType}';
    final eventData = '$eventName ${event.toJson()}';
    _logger.d(eventData);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Picture-in-Picture'),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: PlayerView(
              player: _player,
              key: _playerViewKey,
              onPictureInPictureEnter: _onEvent,
              onPictureInPictureEntered: _onEvent,
              onPictureInPictureExit: _onEvent,
              onPictureInPictureExited: _onEvent,
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
                  onPressed: () {},
                  child: const Text('Enter PiP'),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue),
                  ),
                  onPressed: () {},
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
