import 'package:bitmovin_player/bitmovin_player.dart';

class Sources {
  static const kronehit = SourceConfig(
    url: 'https://cph-msl.akamaized.net/hls/live/2000341/test/master.m3u8',
    type: SourceType.hls,
  );
  static const artOfMotion = SourceConfig(
    url:
        'https://cdn.bitmovin.com/content/assets/MI201109210084/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8',
    type: SourceType.hls,
  );
  static const sintel = SourceConfig(
    url: 'https://cdn.bitmovin.com/content/assets/sintel/hls/playlist.m3u8',
    type: SourceType.hls,
  );
}
