import 'dart:async';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:player_testing/env/env.dart';
import 'package:player_testing/src/events.dart';
import 'package:player_testing/src/multiple_events_expectation.dart';
import 'package:player_testing/src/player_world.dart';
import 'package:player_testing/src/single_event_expectation.dart';

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
    P(E.ready),
  );
}

Future<T> callPlayerAndExpectEvent<T extends Event>(
  Future<void> Function(Player) playerCaller,
  SingleEventExpectation eventExpectation,
) async {
  return PlayerWorld.sharedWorld
      .callPlayerAndExpectEvent(playerCaller, eventExpectation);
}

Future<void> callPlayer(
  Future<void> Function(Player) playerCaller,
) async {
  return PlayerWorld.sharedWorld.callPlayer(playerCaller);
}

// TODO(mario): add support for `eventHandlerBlock`
Future<T> expectEvent<T extends Event>(
  SingleEventExpectation eventExpectation,
) async {
  return PlayerWorld.sharedWorld.expectEvent(eventExpectation);
}

// TODO(mario): add support for `eventHandlerBlock`
Future<void> expectEvents(
  MultipleEventsExpectation multipleEventExpectation,
) async {
  return PlayerWorld.sharedWorld.expectEvents(multipleEventExpectation);
}
