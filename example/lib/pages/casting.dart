import 'dart:io';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player_example/controls.dart';
import 'package:bitmovin_player_example/env/env.dart';
import 'package:flutter/material.dart';

class Casting extends StatefulWidget {
  const Casting({super.key});

  static String routeName = 'Casting';

  @override
  State<Casting> createState() => _CastingState();
}

class _PlayerState {
  _PlayerState(this.player, this.castManager);

  final Player player;
  final BitmovinCastManager castManager;
}

class _CastingState extends State<Casting> {
  final _sourceConfig = SourceConfig(
    url: Platform.isAndroid
        ? 'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/mpds/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.mpd'
        : 'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8',
    type: Platform.isAndroid ? SourceType.dash : SourceType.hls,
  );

  final Future<_PlayerState> _playerState = () async {
    // The cast manager must be created before the player.
    final castManager = await BitmovinCastManager.initialize();
    final player = Player(
      config: const PlayerConfig(
        key: Env.bitmovinPlayerLicenseKey,
      ),
    );
    return _PlayerState(player, castManager);
  }();

  @override
  void initState() {
    _playerState.then((state) => state.player.loadSourceConfig(_sourceConfig));
    super.initState();
  }

  @override
  void dispose() {
    _playerState.then((state) => state.player.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Playback'),
      ),
      body: FutureBuilder(future: _playerState, builder: buildPlayer),
    );
  }

  Widget buildPlayer(BuildContext _, AsyncSnapshot<_PlayerState> snapshot) {
    final data = snapshot.data;
    if (data != null) {
      return buildWithPlayer(data.player, data.castManager);
    }
    final error = snapshot.error;
    if (error != null) {
      return Text('Platform error when creating Player: $error');
    }
    return const Text('Loading player...');
  }

  Widget buildWithPlayer(Player player, BitmovinCastManager castManager) {
    return Column(
      children: [
        SizedBox.fromSize(
          size: const Size.fromHeight(226),
          child: PlayerView(
            player: player,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: Controls(
            onLoadPressed: () => player.loadSourceConfig(_sourceConfig),
            onPlayPressed: player.play,
            onPausePressed: player.pause,
            onMutePressed: player.mute,
            onUnmutePressed: player.unmute,
            onSkipForwardPressed: () async =>
                player.seek(await player.currentTime + 10),
            onSkipBackwardPressed: () async =>
                player.seek(await player.currentTime - 10),
          ),
        ),
        Row(
          children: [
            OutlinedButton(
              onPressed: player.castVideo,
              child: const Text('Cast Video'),
            ),
            OutlinedButton(
              onPressed: player.castStop,
              child: const Text('Stop Casting'),
            ),
          ],
        ),
        Row(
          children: [
            OutlinedButton(
              onPressed: () => castManager.sendMessage(message: 'message'),
              child: const Text('Send cast message'),
            ),
          ],
        ),
      ],
    );
  }
}
