import 'dart:async';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player_example/env/env.dart';
import 'package:logger/logger.dart';

final _logger = Logger();

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
  _logger.d('loadSourceConfig: $sourceConfig');
  final ReadyEvent _ = await PlayerWorld.sharedWorld.callPlayerAndExpectEvent(
    (player) {
      player.loadSourceConfig(sourceConfig);
    },
  );
  _logger.d('loadSourceConfig: we ready');
}

Future<T> callPlayerAndExpectEvent<T extends Event>(
  void Function(Player) playerCaller,
) async {
  return PlayerWorld.sharedWorld.callPlayerAndExpectEvent(playerCaller);
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
    void Function(Player) playerCaller,
  ) async {
    final completer = Completer<T>();
    final eventReceived = completer.future;

    _logger.d('callPlayerAndExpectEvent: $T');
    _player?.onEvent = (receivedEvent) {
      _logger.d('receivedEvent: $receivedEvent, $T');
      if (receivedEvent is T) {
        _logger.d('completer!');
        completer.complete(receivedEvent);
      }
    };
    _player?.onReady = (receivedEvent) {
      _logger.d('receivedEvent onReady: $receivedEvent');
    };

    playerCaller.call(_player!);
    return eventReceived;
  }
}
