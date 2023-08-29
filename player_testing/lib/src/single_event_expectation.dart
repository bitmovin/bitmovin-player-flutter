import 'package:bitmovin_player/bitmovin_player.dart';

abstract class SingleEventExpectation<T extends Event> {
  bool get isFulfilled;
  Type get eventType;
  bool maybeFulfillExpectation(Event receivedEvent);
}

class PlainEventExpectation<T extends Event> extends SingleEventExpectation<T> {
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
