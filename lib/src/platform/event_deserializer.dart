import 'dart:convert';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:logger/logger.dart';

/// Deserializes events that have been sent through a event channel.
class EventDeserializer {
  final Logger _logger = Logger();

  /// Takes an event payload as JSON that was received from the platform side
  /// through an event channel and deserializes it to a typed event object.
  Event? deserialize(dynamic eventPayload) {
    if (eventPayload == null || eventPayload is! String) {
      _logger.e('Received event is null or not a String');
      return null;
    }

    final target = jsonDecode(eventPayload) as Map<String, dynamic>;
    final eventName = target['event'];
    final data = target['data'];

    if (eventName is! String || data is! Map<String, dynamic>) {
      _logger.e('Could not find valid event data');
      return null;
    }

    switch (eventName) {
      case 'onSourceAdded':
      case 'onSourceAddedEvent':
        return SourceAddedEvent.fromJson(data);
      case 'onSourceRemoved':
      case 'onSourceRemovedEvent':
        return SourceRemovedEvent.fromJson(data);
      case 'onSourceLoad':
        return SourceLoadEvent.fromJson(data);
      case 'onSourceLoaded':
        return SourceLoadedEvent.fromJson(data);
      case 'onSourceUnloaded':
        return SourceUnloadedEvent.fromJson(data);
      case 'onSourceWarning':
        return SourceWarningEvent.fromJson(data);
      case 'onSourceError':
        return SourceErrorEvent.fromJson(data);
      case 'onSourceInfo':
        return SourceInfoEvent.fromJson(data);
      case 'onTimeChanged':
        return TimeChangedEvent.fromJson(data);
      case 'onPlay':
        return PlayEvent.fromJson(data);
      case 'onPlaying':
        return PlayingEvent.fromJson(data);
      case 'onPaused':
        return PausedEvent.fromJson(data);
      case 'onMuted':
        return MutedEvent.fromJson(data);
      case 'onUnmuted':
        return UnmutedEvent.fromJson(data);
      case 'onSeeked':
        return SeekedEvent.fromJson(data);
      case 'onSeek':
        return SeekEvent.fromJson(data);
      case 'onTimeShift':
        return TimeShiftEvent.fromJson(data);
      case 'onTimeShifted':
        return TimeShiftedEvent.fromJson(data);
      case 'onPlaybackFinished':
        return PlaybackFinishedEvent.fromJson(data);
      case 'onPlayerError':
        return ErrorEvent.fromJson(data);
      case 'onPlayerInfo':
        return InfoEvent.fromJson(data);
      case 'onPlayerWarning':
        return WarningEvent.fromJson(data);
      case 'onReady':
        return ReadyEvent.fromJson(data);
      case 'onSubtitleAdded':
        return SubtitleAddedEvent.fromJson(data);
      case 'onSubtitleRemoved':
        return SubtitleRemovedEvent.fromJson(data);
      case 'onSubtitleChanged':
        return SubtitleChangedEvent.fromJson(data);
      case 'onCueEnter':
        return CueEnterEvent.fromJson(data);
      case 'onCueExit':
        return CueExitEvent.fromJson(data);
      case 'onCastAvailable':
        return CastAvailableEvent.fromJson(data);
      case 'onCastWaitingForDevice':
        return CastWaitingForDeviceEvent.fromJson(data);
      case 'onCastStart':
        return CastStartEvent.fromJson(data);
      case 'onCastStarted':
        return CastStartedEvent.fromJson(data);
      case 'onCastStopped':
        return CastStoppedEvent.fromJson(data);
      case 'onCastTimeUpdated':
        return CastTimeUpdatedEvent.fromJson(data);
      case 'onAirPlayAvailable':
      case 'onAirplayAvailable':
        return AirPlayAvailableEvent.fromJson(data);
      case 'onAirPlayChanged':
        return AirPlayChangedEvent.fromJson(data);
      case 'onFullscreenEnter':
        return FullscreenEnterEvent.fromJson(data);
      case 'onFullscreenExit':
        return FullscreenExitEvent.fromJson(data);
      case 'onPictureInPictureEnter':
        return PictureInPictureEnterEvent.fromJson(data);
      case 'onPictureInPictureEntered':
        return PictureInPictureEnteredEvent.fromJson(data);
      case 'onPictureInPictureExit':
        return PictureInPictureExitEvent.fromJson(data);
      case 'onPictureInPictureExited':
        return PictureInPictureExitedEvent.fromJson(data);
    }

    _logger.e('Received unknown event type: $eventName');
    return null;
  }
}
