import 'dart:async';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:player_testing/src/multiple_events_expectation.dart';
import 'package:player_testing/src/single_event_expectation.dart';

class PlayerWorld {
  PlayerWorld._();
  static final _instance = PlayerWorld._();
  static PlayerWorld get sharedWorld => _instance;
  Player? _player;

  Future<void> startPlayerTest(
    PlayerConfig playerConfig,
  ) async {
    if (_player != null) {
      await _player?.dispose();
      _player = null;
    }

    _player = Player(config: playerConfig);
  }

  Future<T> callPlayerAndExpectEvent<T extends Event>(
    Future<void> Function(Player) playerCaller,
    SingleEventExpectation eventExpectation,
  ) async {
    final eventReceived = expectEvent<T>(eventExpectation);
    await playerCaller.call(_player!);
    return eventReceived;
  }

  Future<void> callPlayerAndExpectEvents(
    Future<void> Function(Player) playerCaller,
    MultipleEventsExpectation eventExpectation,
  ) async {
    final eventsReceived = expectEvents(eventExpectation);
    await playerCaller.call(_player!);
    return eventsReceived;
  }

  Future<void> callPlayer(
    Future<void> Function(Player) playerCaller,
  ) async {
    await playerCaller.call(_player!);
  }

  Future<TimeChangedEvent> playFor(double seconds) async {
    final targetTime = await _player!.currentTime + seconds;
    return playUntil(targetTime);
  }

  Future<TimeChangedEvent> playUntil(double time) async {
    final reachedTime = expectEvent<TimeChangedEvent>(
      F(E.timeChanged, (event) {
        return event.time >= time;
      }),
    );

    await _player?.play();

    return reachedTime;
  }

  Future<T> expectEvent<T extends Event>(
    SingleEventExpectation eventExpectation,
  ) async {
    final completer = Completer<T>();
    final eventReceived = completer.future;

    _player?.onEvent = (receivedEvent) {
      if (!completer.isCompleted &&
          eventExpectation.maybeFulfillExpectation(receivedEvent)) {
        completer.complete(receivedEvent as T);
      }
    };

    return eventReceived;
  }

  Future<void> expectEvents(
    MultipleEventsExpectation multipleEventsExpectation,
  ) async {
    final completer = Completer<void>();
    final eventReceived = completer.future;
    var fulfilledExpectations = 0;

    _player?.onEvent = (receivedEvent) {
      if (!completer.isCompleted &&
          multipleEventsExpectation.isNextExpectationMet(receivedEvent)) {
        fulfilledExpectations++;
        if (fulfilledExpectations >=
            multipleEventsExpectation.expectedFulfillmentCount) {
          completer.complete();
        }
      }
    };

    return eventReceived;
  }
}
