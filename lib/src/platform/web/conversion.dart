import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/platform/web/bitmovin_player_web_api.dart';

extension SourceToJs on Source {
  SourceJs toSourceJs() {
    return SourceJs(
      title: sourceConfig.title,
      description: sourceConfig.description,
      dash: _dashUrl,
      hls: _hlsUrl,
      poster: sourceConfig.posterSource,
    );
  }

  String? get _dashUrl {
    return sourceConfig.type == SourceType.dash ? sourceConfig.url : null;
  }

  String? get _hlsUrl {
    return sourceConfig.type == SourceType.hls ? sourceConfig.url : null;
  }
}
