import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:collection/collection.dart';
import 'package:player_testing/player_testing.dart';

typedef S = EventSequenceExpectation;
typedef B = EventBagExpectation;
typedef R = RepeatedEventExpectation;
typedef A = AnyEventExpectation;

abstract class MultipleEventsExpectation {
  List<SingleEventExpectation> get singleExpectations;
  int get expectedFulfillmentCount;
  bool isNextExpectationMet(Event receivedEvent);
}

class EventSequenceExpectation implements MultipleEventsExpectation {
  EventSequenceExpectation(this.singleExpectations);

  @override
  final List<SingleEventExpectation> singleExpectations;
  @override
  int get expectedFulfillmentCount => singleExpectations.length;

  @override
  bool isNextExpectationMet(Event receivedEvent) {
    final nextUnfulfilled = singleExpectations
        .firstWhereOrNull((expectation) => !expectation.isFulfilled);
    if (nextUnfulfilled == null) {
      return true;
    }

    return nextUnfulfilled.maybeFulfillExpectation(receivedEvent);
  }
}

class EventBagExpectation implements MultipleEventsExpectation {
  EventBagExpectation(this.singleExpectations);

  @override
  final List<SingleEventExpectation> singleExpectations;
  @override
  int get expectedFulfillmentCount => singleExpectations.length;

  @override
  bool isNextExpectationMet(Event receivedEvent) {
    final nextUnfulfilled = singleExpectations.firstWhereOrNull(
      (expectation) =>
          !expectation.isFulfilled &&
          expectation.maybeFulfillExpectation(receivedEvent),
    );

    return nextUnfulfilled?.isFulfilled ?? false;
  }
}

class RepeatedEventExpectation extends EventSequenceExpectation {
  RepeatedEventExpectation(SingleEventExpectation singleExpectation, int count)
      : super(
          List<int>.filled(count, 0)
              .map((_) => singleExpectation.copy())
              .toList(),
        );
}

class AnyEventExpectation implements MultipleEventsExpectation {
  AnyEventExpectation(this.singleExpectations);

  @override
  final List<SingleEventExpectation> singleExpectations;
  @override
  int get expectedFulfillmentCount => 1;

  @override
  bool isNextExpectationMet(Event receivedEvent) {
    final nextUnfulfilled = singleExpectations.firstWhereOrNull(
      (expectation) => expectation.maybeFulfillExpectation(receivedEvent),
    );

    return nextUnfulfilled?.isFulfilled ?? false;
  }
}
