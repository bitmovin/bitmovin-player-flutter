import 'dart:async';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player_example/env/env.dart';

Future<void> startPlayerTest(
  Future<void> Function() testBlock, {
  PlayerConfig playerConfig =
      const PlayerConfig(key: Env.bitmovinPlayerLicenseKey),
}) async {
  PlayerWorld.sharedWorld.startPlayerTest(playerConfig);
  await testBlock.call();
}

Future<dynamic> loadSourceConfig(
  SourceConfig sourceConfig,
) async {
  final ReadyEvent _ = await PlayerWorld.sharedWorld.callPlayerAndExpectEvent(
    (player) async {
      await player.loadSourceConfig(sourceConfig);
    },
  );
}

Future<T> callPlayerAndExpectEvent<T extends Event>(
  Future<void> Function(Player) playerCaller,
) async {
  return PlayerWorld.sharedWorld.callPlayerAndExpectEvent(playerCaller);
}

Future<void> callPlayer(
  Future<void> Function(Player) playerCaller,
) async {
  return PlayerWorld.sharedWorld.callPlayer(playerCaller);
}

Future<T> expectEvent<T extends Event>() async {
  return PlayerWorld.sharedWorld.expectEvent();
}

class PlayerWorld {
  PlayerWorld._();
  static final _instance = PlayerWorld._();
  static PlayerWorld get sharedWorld => _instance;

  Player? _player;

  void startPlayerTest(
    PlayerConfig playerConfig,
  ) {
    // TODO(mario): tear down previous player
    _player = Player(config: playerConfig);
  }

  Future<T> callPlayerAndExpectEvent<T extends Event>(
    Future<void> Function(Player) playerCaller,
  ) async {
    final completer = Completer<T>();
    final eventReceived = completer.future;

    _player?.onEvent = (receivedEvent) {
      if (receivedEvent is T) {
        completer.complete(receivedEvent);
      }
    };

    await playerCaller.call(_player!);
    return eventReceived;
  }

  Future<void> callPlayer(
    Future<void> Function(Player) playerCaller,
  ) async {
    await playerCaller.call(_player!);
  }

  Future<T> expectEvent<T extends Event>() async {
    final completer = Completer<T>();
    final eventReceived = completer.future;

    _player?.onEvent = (receivedEvent) {
      if (receivedEvent is T) {
        completer.complete(receivedEvent);
      }
    };
    return eventReceived;
  }
}
