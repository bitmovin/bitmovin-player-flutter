import 'dart:async';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player_example/env/env.dart';
import 'player_world.dart';
import 'single_event_expectation.dart';

// TODO(mario): split up and extract components to own files
// TODO(mario): move framework code to better place within the project, it
// should not be within the integration test folder.

abstract class E {
  static const ready = ReadyEvent(timestamp: 0);
  static const timeShift = TimeShiftEvent(position: 0, target: 0, timestamp: 0);
  static const timeShifted = TimeShiftedEvent(timestamp: 0);
  static const timeChanged = TimeChangedEvent(time: 0, timestamp: 0);
}

Future<void> startPlayerTest(
  Future<void> Function() testBlock, {
  PlayerConfig playerConfig =
      const PlayerConfig(key: Env.bitmovinPlayerLicenseKey),
}) async {
  await PlayerWorld.sharedWorld.startPlayerTest(playerConfig);
  await testBlock.call();
}

Future<dynamic> loadSourceConfig(
  SourceConfig sourceConfig,
) async {
  await PlayerWorld.sharedWorld.callPlayerAndExpectEvent(
    (player) async {
      await player.loadSourceConfig(sourceConfig);
    },
    E.ready,
  );
}

Future<T> callPlayerAndExpectEvent<T extends Event>(
  Future<void> Function(Player) playerCaller,
  T event,
) async {
  return PlayerWorld.sharedWorld.callPlayerAndExpectEvent(playerCaller, event);
}

Future<void> callPlayer(
  Future<void> Function(Player) playerCaller,
) async {
  return PlayerWorld.sharedWorld.callPlayer(playerCaller);
}

Future<T> expectEvent<T extends Event>(T event) async {
  return PlayerWorld.sharedWorld.expectEvent(event);
}

Future<T> expectSingleEvent<T extends Event>(
    SingleEventExpectation<T> eventExpectation) async {
  return PlayerWorld.sharedWorld.expectSingleEvent(eventExpectation);
}
