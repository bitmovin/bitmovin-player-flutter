@JS()
library bitmovinplayer.js;

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
  external bool isLive();
  external bool isCasting();
  external bool isCastAvailable();
  external bool isAirplayActive();
  external bool isAirplayAvailable();
  external double getCurrentTime();
  external double getDuration();
  external double getMaxTimeShift();
  external void on(String event, Function handler);
}

@JS()
@anonymous
class PlayerConfigJs {
  external factory PlayerConfigJs({String key});
  external String get key;
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
class PlaybackEventJs {
  external String get issuer;
  external double get time;
  external int get timestamp;
  external String get type;
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
