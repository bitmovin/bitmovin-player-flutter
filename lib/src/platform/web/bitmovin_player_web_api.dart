import 'package:js/js.dart';
import 'package:web/web.dart';

@JS('bitmovin.player.Player')
class BitmovinPlayerJs {
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
  external void on(String event, Function handler);
  external bool addMetadata(String metadataType, Object metadata);
}

@JS()
@anonymous
class PlayerConfigJs {
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
class PlaybackConfigJs {
  external factory PlaybackConfigJs({
    bool autoplay,
    bool muted,
  });
  external bool get autoplay;
  external bool get muted;
}

@JS()
@anonymous
class LicensingConfigJs {
  external factory LicensingConfigJs({
    int? delay,
  });
  external int? get delay;
}

@JS()
@anonymous
class GoogleCastRemoteControlConfigJs {
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
class SourceJs {
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
class PlayerEventBaseJs {
  external int get timestamp;
  external String get type;
}

@JS()
@anonymous
class UserInteractionEventJs extends PlayerEventBaseJs {
  external String? get issuer;
}

@JS()
@anonymous
class PlaybackEventJs extends UserInteractionEventJs {
  external double get time;
}

@JS()
@anonymous
class SeekEventJs {
  external String get issuer;
  external double get position;
  external double get seekTarget;
  external int get timestamp;
  external String get type;
}

@JS()
@anonymous
class TimeShiftEventJs extends UserInteractionEventJs {
  external double get position;
  external double get target;
}

@JS()
@anonymous
class ErrorEventJs extends PlayerEventBaseJs {
  external int get code;
  external String? get message;
}

@JS()
@anonymous
class WarningEventJs extends PlayerEventBaseJs {
  external int get code;
  external String? get message;
}

@JS()
@anonymous
class CastAvailableEventJs extends PlayerEventBaseJs {
  external bool get receiverAvailable;
}

@JS()
@anonymous
class CastStartedEventJs extends PlayerEventBaseJs {
  external String get deviceName;
  external bool get resuming;
}

@JS()
@anonymous
class CastWaitingForDeviceEventJs extends PlayerEventBaseJs {
  external CastPayloadJs get castPayload;
}

@JS()
@anonymous
class CastPayloadJs {
  external double get currentTime;
  external String? get deviceName;
}
