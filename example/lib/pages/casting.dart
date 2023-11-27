import 'dart:async';
import 'dart:io';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player_example/controls.dart';
import 'package:bitmovin_player_example/env/env.dart';
import 'package:bitmovin_player_example/player_view_container.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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

const artOfMotionDash =
    'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/mpds/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.mpd';
const artOfMotionHls =
    'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8';

final SourceConfig _sourceConfig = Platform.isAndroid
    ? const SourceConfig(url: artOfMotionDash, type: SourceType.dash)
    : const SourceConfig(url: artOfMotionHls, type: SourceType.hls);

class _CastingState extends State<Casting> {
  factory _CastingState() {
    final logger = Logger();
    void eventListener(Event event) => _onEvent(logger, event);

    return _CastingState._(createPlayerState(_sourceConfig, eventListener));
  }

  _CastingState._(this._playerState);

  final Future<_PlayerState> _playerState;

  static Future<_PlayerState> createPlayerState(
    SourceConfig sourceConfig,
    void Function(Event event) eventListener,
  ) async {
    final castManager = await BitmovinCastManager.initialize();
    final player = Player(
      config: const PlayerConfig(
        key: Env.bitmovinPlayerLicenseKey,
        remoteControlConfig: RemoteControlConfig(
          customReceiverConfig: {'key': 'value'},
        ),
      ),
    )
      ..onCastAvailable = eventListener
      ..onCastWaitingForDevice = eventListener
      ..onCastStart = eventListener
      ..onCastStarted = eventListener
      ..onCastStopped = eventListener
      ..onCastTimeUpdated = eventListener;

    // Configure playing DASH source on Chromecast, even if on iOS the local
    // played back asset is HLS. This is to demonstrate how a different source
    // can be used for remote playback than for local playback.
    final source = Source(
      sourceConfig: sourceConfig,
      remoteControl: const SourceRemoteControlConfig(
        castSourceConfig: SourceConfig(
          url: artOfMotionDash,
          type: SourceType.dash,
        ),
      ),
    );

    await player.loadSource(source);
    return _PlayerState(player, castManager);
  }

  static void _onEvent(
    Logger logger,
    Event event,
  ) {
    final eventName = '${event.runtimeType}';
    final eventData = '$eventName ${event.toJson()}';
    logger.d(eventData);
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
        title: const Text('Casting'),
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
        PlayerViewContainer(player: player),
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
            Container(
              margin: const EdgeInsets.only(left: 10, right: 5),
              child: OutlinedButton(
                onPressed: player.castVideo,
                child: const Text('Cast Video'),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              child: OutlinedButton(
                onPressed: player.castStop,
                child: const Text('Stop Casting'),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, right: 5),
              child: OutlinedButton(
                onPressed: () => castManager.sendMessage(message: 'message'),
                child: const Text('Send cast message'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
