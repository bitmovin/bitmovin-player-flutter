import 'package:bitmovin_player/bitmovin_player.dart';

typedef P<T extends Event> = PlainEventExpectation<T>;
typedef F<T extends Event> = FilteredEventExpectation<T>;

abstract class SingleEventExpectation {
  bool get isFulfilled;
  Type get eventType;
  bool maybeFulfillExpectation(Event receivedEvent);
}

class PlainEventExpectation<T extends Event> implements SingleEventExpectation {
  PlainEventExpectation(T event) {
    this.eventType = event.runtimeType;
  }

  @override
  late final Type eventType;
  @override
  bool isFulfilled = false;

  @override
  bool maybeFulfillExpectation(Event receivedEvent) {
    return isFulfilled = receivedEvent is T;
  }
}

class FilteredEventExpectation<T extends Event>
    extends PlainEventExpectation<T> {
  FilteredEventExpectation(super.event, this.filter);

  final bool Function(T) filter;

  @override
  bool maybeFulfillExpectation(Event receivedEvent) {
    if (super.maybeFulfillExpectation(receivedEvent)) {
      isFulfilled = filter(receivedEvent as T);
    }
    return isFulfilled;
  }
}
