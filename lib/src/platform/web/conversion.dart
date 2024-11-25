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

extension SourceFromJs on SourceJs {
  Source toSource(String streamType) {
    return Source(
      sourceConfig: SourceConfig(
        title: title,
        description: description,
        url: _getUrl(streamType),
        type: _getType(streamType),
        posterSource: poster,
      ),
    );
  }

  String _getUrl(String streamType) {
    switch (streamType) {
      case StreamTypeJS.dash:
        return dash!;
      case StreamTypeJS.hls:
        return hls!;
      default:
        throw ArgumentError('Unsupported stream type: Cannot determine URL');
    }
  }

  SourceType _getType(String streamType) {
    switch (streamType) {
      case StreamTypeJS.dash:
        return SourceType.dash;
      case StreamTypeJS.hls:
        return SourceType.hls;
      default:
        throw ArgumentError(
          'Unsupported stream type: Cannot determine source type',
        );
    }
  }
}

extension SeekEventFromJs on SeekEventJs {
  SeekEvent toSeekEvent(Source source) {
    return SeekEvent(
      from: SeekPosition(source: source, time: position),
      to: SeekPosition(source: source, time: seekTarget),
      timestamp: timestamp,
    );
  }
}

extension PlayEventFromJs on PlaybackEventJs {
  PlayEvent toPlayEvent() {
    return PlayEvent(time: time, timestamp: timestamp);
  }
}