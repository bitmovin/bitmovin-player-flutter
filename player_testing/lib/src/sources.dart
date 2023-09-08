import 'package:bitmovin_player/bitmovin_player.dart';

class Sources {
  static const kronehit = SourceConfig(
    url: 'https://bitcdn-kronehit.bitmovin.com/v2/hls/playlist.m3u8',
    type: SourceType.hls,
  );
  static const artOfMotion = SourceConfig(
    url:
        'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8',
    type: SourceType.hls,
  );
}
