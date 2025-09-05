import 'package:bitmovin_player/bitmovin_player.dart';

typedef P<T extends Event> = PlainEventExpectation<T>;
typedef F<T extends Event> = FilteredEventExpectation<T>;

abstract class SingleEventExpectation<T extends Event> {
  bool get isFulfilled;
  Type get eventType;
  bool maybeFulfillExpectation(Event receivedEvent);
  SingleEventExpectation<T> copy();
}

/// To expect an event of a given type to occur.
class PlainEventExpectation<T extends Event>
    implements SingleEventExpectation<T> {
  PlainEventExpectation(T event) {
    eventType = event.runtimeType;
  }

  PlainEventExpectation.from(PlainEventExpectation other) {
    eventType = other.eventType;
  }

  @override
  late final Type eventType;
  @override
  bool isFulfilled = false;

  @override
  bool maybeFulfillExpectation(Event receivedEvent) {
    return isFulfilled = receivedEvent is T;
  }

  @override
  // ignore: use_to_and_as_if_applicable
  SingleEventExpectation<T> copy() {
    return PlainEventExpectation<T>.from(this);
  }
}

/// To expect an event of a given type with a certain condition to occur.
class FilteredEventExpectation<T extends Event>
    extends PlainEventExpectation<T> {
  FilteredEventExpectation(super.event, this.filter);
  FilteredEventExpectation.from(FilteredEventExpectation other)
      : super.from(other) {
    filter = other.filter;
  }

  late final bool Function(T) filter;

  @override
  bool maybeFulfillExpectation(Event receivedEvent) {
    if (super.maybeFulfillExpectation(receivedEvent)) {
      isFulfilled = filter(receivedEvent as T);
    }
    return isFulfilled;
  }

  @override
  // ignore: use_to_and_as_if_applicable
  SingleEventExpectation<T> copy() {
    return FilteredEventExpectation<T>.from(this);
  }
}
