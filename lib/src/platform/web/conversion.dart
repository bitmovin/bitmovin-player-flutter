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

extension PlayerConfigToJs on PlayerConfig {
  PlayerConfigJs toPlayerConfigJs() {
    return PlayerConfigJs(
      key: key,
      playback: playbackConfig?.toPlaybackConfigJs(),
      licensing: licensingConfig?.toLicensingConfigJs(),
    );
  }
}

extension PlaybackConfigToJs on PlaybackConfig {
  PlaybackConfigJs toPlaybackConfigJs() {
    return PlaybackConfigJs(
      autoplay: isAutoplayEnabled,
      muted: isMuted,
    );
  }
}

extension LicensingConfigToJs on LicensingConfig {
  LicensingConfigJs toLicensingConfigJs() {
    return LicensingConfigJs(delay: delay);
  }
}

extension PlayerEventBaseConversion on PlayerEventBaseJs {
  SeekedEvent toSeekedEvent() {
    return SeekedEvent(timestamp: timestamp);
  }

  TimeShiftedEvent toTimeShiftedEvent() {
    return TimeShiftedEvent(timestamp: timestamp);
  }

  PlaybackFinishedEvent toPlaybackFinishedEvent() {
    return PlaybackFinishedEvent(timestamp: timestamp);
  }

  ReadyEvent toReadyEvent() {
    return ReadyEvent(timestamp: timestamp);
  }

  SourceLoadedEvent toSourceLoadedEvent(Source source) {
    return SourceLoadedEvent(source: source, timestamp: timestamp);
  }

  SourceUnloadedEvent toSourceUnloadedEvent() {
    return SourceUnloadedEvent(timestamp: timestamp);
  }
}

extension UserInteractionEventConversion on UserInteractionEventJs {
  MutedEvent toMutedEvent() {
    return MutedEvent(timestamp: timestamp);
  }

  UnmutedEvent toUnmutedEvent() {
    return UnmutedEvent(timestamp: timestamp);
  }
}

extension PlaybackEventConversion on PlaybackEventJs {
  PlayEvent toPlayEvent() {
    return PlayEvent(time: time, timestamp: timestamp);
  }

  PlayingEvent toPlayingEvent() {
    return PlayingEvent(time: time, timestamp: timestamp);
  }

  PausedEvent toPausedEvent() {
    return PausedEvent(time: time, timestamp: timestamp);
  }

  TimeChangedEvent toTimeChangedEvent() {
    return TimeChangedEvent(time: time, timestamp: timestamp);
  }
}

extension SeekEventConversion on SeekEventJs {
  SeekEvent toSeekEvent(Source source) {
    return SeekEvent(
      from: SeekPosition(source: source, time: position),
      to: SeekPosition(source: source, time: seekTarget),
      timestamp: timestamp,
    );
  }
}

extension TimeShiftEventConversion on TimeShiftEventJs {
  TimeShiftEvent toTimeShiftEvent() {
    return TimeShiftEvent(
      position: position,
      target: target,
      timestamp: timestamp,
    );
  }
}

extension ErrorEventConversion on ErrorEventJs {
  ErrorEvent toErrorEvent() {
    return ErrorEvent(
      code: code,
      message: message,
      timestamp: timestamp,
    );
  }
}

extension WarningEventConversion on WarningEventJs {
  WarningEvent toWarningEvent() {
    return WarningEvent(
      code: code,
      message: message,
      timestamp: timestamp,
    );
  }
}
