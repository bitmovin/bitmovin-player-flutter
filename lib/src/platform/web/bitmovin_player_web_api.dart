import 'dart:js_interop';

import 'package:web/web.dart';

@JS('bitmovin.player.Player')
extension type BitmovinPlayerJs._(JSObject _) implements JSObject {
  external factory BitmovinPlayerJs(Element container, PlayerConfigJs config);
  external void play();
  external void pause();
  external void mute();
  external void unmute();
  external void load(SourceJs source);
  external void seek(double time);
  external void timeShift(double offset);
  external double getTimeShift();
  external void destroy();
  external void castVideo();
  external void castStop();
  external bool isPlaying();
  external bool isPaused();
  external bool isMuted();
  external bool isLive();
  external bool isCasting();
  external bool isCastAvailable();
  external bool isAirplayActive();
  external bool isAirplayAvailable();
  external double getCurrentTime();
  external double getDuration();
  external double getMaxTimeShift();
  external SourceJs? getSource();
  external String getStreamType();
  external void showAirplayTargetPicker();
  external void on(String event, JSFunction handler);
  external bool addMetadata(String metadataType, JSAny metadata);
}

@JS()
@anonymous
extension type PlayerConfigJs._(JSObject _) implements JSObject {
  external factory PlayerConfigJs({
    String? key,
    PlaybackConfigJs? playback,
    LicensingConfigJs? licensing,
    GoogleCastRemoteControlConfigJs? remotecontrol,
  });
  external String? get key;
  external PlaybackConfigJs? get playback;
  external LicensingConfigJs? get licensing;
  external GoogleCastRemoteControlConfigJs? get remotecontrol;
}

@JS()
@anonymous
extension type PlaybackConfigJs._(JSObject _) implements JSObject {
  external factory PlaybackConfigJs({
    bool autoplay,
    bool muted,
  });
  external bool get autoplay;
  external bool get muted;
}

@JS()
@anonymous
extension type LicensingConfigJs._(JSObject _) implements JSObject {
  external factory LicensingConfigJs({
    int? delay,
  });
  external int? get delay;
}

@JS()
@anonymous
extension type GoogleCastRemoteControlConfigJs._(JSObject _)
    implements JSObject {
  external factory GoogleCastRemoteControlConfigJs({
    required String type,
    String? receiverApplicationId,
    String? messageNamespace,
  });

  // Factory method to allow having a default value for `type` when creating
  // instances directly from Dart code.
  // ignore: prefer_constructors_over_static_methods
  static GoogleCastRemoteControlConfigJs create(
    String? receiverApplicationId,
    String? messageNamespace,
  ) {
    return GoogleCastRemoteControlConfigJs(
      type: 'googlecast',
      receiverApplicationId: receiverApplicationId,
      messageNamespace: messageNamespace,
    );
  }

  external String get type;
  external String? get receiverApplicationId;
  external String? get messageNamespace;
}

class StreamTypeJS {
  static const dash = 'dash';
  static const hls = 'hls';
}

@JS()
@anonymous
extension type SourceJs._(JSObject _) implements JSObject {
  external factory SourceJs({
    String? title,
    String? description,
    String? dash,
    String? hls,
    String? poster,
  });
  external String? get title;
  external String? get description;
  external String? get dash;
  external String? get hls;
  external String? get poster;
}

@JS()
@anonymous
extension type PlayerEventBaseJs._(JSObject _) implements JSObject {
  external int get timestamp;
  external String get type;
}

@JS()
@anonymous
extension type UserInteractionEventJs._(JSObject _)
    implements PlayerEventBaseJs {
  external String? get issuer;
}

@JS()
@anonymous
extension type PlaybackEventJs._(JSObject _) implements UserInteractionEventJs {
  external double get time;
}

@JS()
@anonymous
extension type SeekEventJs._(JSObject _) implements JSObject {
  external String get issuer;
  external double get position;
  external double get seekTarget;
  external int get timestamp;
  external String get type;
}

@JS()
@anonymous
extension type TimeShiftEventJs._(JSObject _)
    implements UserInteractionEventJs {
  external double get position;
  external double get target;
}

@JS()
@anonymous
extension type ErrorEventJs._(JSObject _) implements PlayerEventBaseJs {
  external int get code;
  external String? get message;
}

@JS()
@anonymous
extension type WarningEventJs._(JSObject _) implements PlayerEventBaseJs {
  external int get code;
  external String? get message;
}

@JS()
@anonymous
extension type CastAvailableEventJs._(JSObject _) implements PlayerEventBaseJs {
  external bool get receiverAvailable;
}

@JS()
@anonymous
extension type CastStartedEventJs._(JSObject _) implements PlayerEventBaseJs {
  external String get deviceName;
  external bool get resuming;
}

@JS()
@anonymous
extension type CastWaitingForDeviceEventJs._(JSObject _)
    implements PlayerEventBaseJs {
  external CastPayloadJs get castPayload;
}

@JS()
@anonymous
extension type CastPayloadJs._(JSObject _) implements JSObject {
  external double get currentTime;
  external String? get deviceName;
}
