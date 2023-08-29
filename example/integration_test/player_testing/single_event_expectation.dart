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
  var isFulfilled = false;

  @override
  bool maybeFulfillExpectation(Event receivedEvent) {
    isFulfilled = receivedEvent is T;
    return isFulfilled;
  }
}

class FilteredEventExpectation<T extends Event>
    extends PlainEventExpectation<T> {
  FilteredEventExpectation(T event, this.filter) : super(event);

  final bool Function(T) filter;

  @override
  bool maybeFulfillExpectation(Event receivedEvent) {
    if (super.maybeFulfillExpectation(receivedEvent)) {
      isFulfilled = filter(receivedEvent as T);
    }
    return isFulfilled;
  }
}
