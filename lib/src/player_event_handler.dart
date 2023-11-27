import 'dart:convert';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:logger/logger.dart';

mixin PlayerEventHandler implements PlayerListener {
  final Logger _logger = Logger();
  final Map<String, List<void Function(Event)>> _eventListeners = {};

  /// Takes an [Event] and emits it to the corresponding event listener.
  void emit(Event event) {
    final generalListener = _eventListeners[(Event).toString()];
    generalListener?.forEach((element) {
      element.call(event);
    });

    final listener = _eventListeners[event.runtimeType.toString()];
    listener?.forEach((element) {
      element.call(event);
    });
  }

  /// Takes an event as JSON that was received from the native platform,
  /// deserializes it to a typed event object and emits it to the corresponding
  /// event listener.
  void onPlatformEvent(dynamic event) {
    if (event == null || event is! String) {
      _logger.e('Received event is null');
      return;
    }

    final target = jsonDecode(event) as Map<String, dynamic>;
    final eventName = target['event'];
    final data = target['data'];

    if (eventName is! String || data is! Map<String, dynamic>) {
      _logger.e('Could not find valid event data');
      return;
    }

    switch (eventName) {
      case 'onSourceAdded':
        emit(SourceAddedEvent.fromJson(data));
        break;
      case 'onSourceRemoved':
        emit(SourceRemovedEvent.fromJson(data));
        break;
      case 'onSourceLoad':
        emit(SourceLoadEvent.fromJson(data));
        break;
      case 'onSourceLoaded':
        emit(SourceLoadedEvent.fromJson(data));
        break;
      case 'onSourceUnloaded':
        emit(SourceUnloadedEvent.fromJson(data));
        break;
      case 'onSourceWarning':
        emit(SourceWarningEvent.fromJson(data));
        break;
      case 'onSourceError':
        emit(SourceErrorEvent.fromJson(data));
        break;
      case 'onSourceInfo':
        emit(SourceInfoEvent.fromJson(data));
        break;
      case 'onTimeChanged':
        emit(TimeChangedEvent.fromJson(data));
        break;
      case 'onPlay':
        emit(PlayEvent.fromJson(data));
        break;
      case 'onPlaying':
        emit(PlayingEvent.fromJson(data));
        break;
      case 'onPaused':
        emit(PausedEvent.fromJson(data));
        break;
      case 'onMuted':
        emit(MutedEvent.fromJson(data));
        break;
      case 'onUnmuted':
        emit(UnmutedEvent.fromJson(data));
        break;
      case 'onSeeked':
        emit(SeekedEvent.fromJson(data));
        break;
      case 'onSeek':
        emit(SeekEvent.fromJson(data));
        break;
      case 'onTimeShift':
        emit(TimeShiftEvent.fromJson(data));
        break;
      case 'onTimeShifted':
        emit(TimeShiftedEvent.fromJson(data));
        break;
      case 'onPlaybackFinished':
        emit(PlaybackFinishedEvent.fromJson(data));
        break;
      case 'onPlayerError':
        emit(ErrorEvent.fromJson(data));
        break;
      case 'onPlayerInfo':
        emit(InfoEvent.fromJson(data));
        break;
      case 'onPlayerWarning':
        emit(WarningEvent.fromJson(data));
        break;
      case 'onReady':
        emit(ReadyEvent.fromJson(data));
        break;
      case 'onSubtitleAdded':
        emit(SubtitleAddedEvent.fromJson(data));
        break;
      case 'onSubtitleRemoved':
        emit(SubtitleRemovedEvent.fromJson(data));
        break;
      case 'onSubtitleChanged':
        emit(SubtitleChangedEvent.fromJson(data));
        break;
      case 'onCueEnter':
        emit(CueEnterEvent.fromJson(data));
        break;
      case 'onCueExit':
        emit(CueExitEvent.fromJson(data));
        break;
      case 'onCastAvailable':
        emit(CastAvailableEvent.fromJson(data));
        break;
      case 'onCastWaitingForDevice':
        emit(CastWaitingForDeviceEvent.fromJson(data));
        break;
      case 'onCastStart':
        emit(CastStartEvent.fromJson(data));
        break;
      case 'onCastStarted':
        emit(CastStartedEvent.fromJson(data));
        break;
      case 'onCastStopped':
        emit(CastStoppedEvent.fromJson(data));
        break;
      case 'onCastTimeUpdated':
        emit(CastTimeUpdatedEvent.fromJson(data));
        break;
      case 'onAirPlayAvailable':
      case 'onAirplayAvailable':
        emit(AirPlayAvailableEvent.fromJson(data));
        break;
      case 'onAirPlayChanged':
        emit(AirPlayChangedEvent.fromJson(data));
        break;
      case 'onPictureInPictureEnter':
        emit(PictureInPictureEnterEvent.fromJson(data));
        break;
      case 'onPictureInPictureEntered':
        emit(PictureInPictureEnteredEvent.fromJson(data));
        break;
      case 'onPictureInPictureExit':
        emit(PictureInPictureExitEvent.fromJson(data));
        break;
      case 'onPictureInPictureExited':
        emit(PictureInPictureExitedEvent.fromJson(data));
        break;
    }
  }

  void _addListener<T>(void Function(T) listener) {
    final key = T.toString();
    if (_eventListeners[key] == null) {
      _eventListeners[key] = [];
    }

    _eventListeners[key]?.add((Event event) {
      listener(event as T);
    });
  }

  @override
  set onEvent(void Function(Event) func) {
    _addListener(func);
  }

  @override
  set onTimeChanged(void Function(TimeChangedEvent) func) {
    _addListener(func);
  }

  @override
  set onSourceLoad(void Function(SourceLoadEvent) func) {
    _addListener(func);
  }

  @override
  set onSourceLoaded(void Function(SourceLoadedEvent) func) {
    _addListener(func);
  }

  @override
  set onSourceUnloaded(void Function(SourceUnloadedEvent) func) {
    _addListener(func);
  }

  @override
  set onPlay(void Function(PlayEvent) func) {
    _addListener(func);
  }

  @override
  set onPlaying(void Function(PlayingEvent) func) {
    _addListener(func);
  }

  @override
  set onPaused(void Function(PausedEvent) func) {
    _addListener(func);
  }

  @override
  set onMuted(void Function(MutedEvent) func) {
    _addListener(func);
  }

  @override
  set onUnmuted(void Function(UnmutedEvent) func) {
    _addListener(func);
  }

  @override
  set onSourceAdded(void Function(SourceAddedEvent) func) {
    _addListener(func);
  }

  @override
  set onSourceRemoved(void Function(SourceRemovedEvent) func) {
    _addListener(func);
  }

  @override
  set onSeek(void Function(SeekEvent) func) {
    _addListener(func);
  }

  @override
  set onSeeked(void Function(SeekedEvent) func) {
    _addListener(func);
  }

  @override
  set onTimeShift(void Function(TimeShiftEvent) func) {
    _addListener(func);
  }

  @override
  set onTimeShifted(void Function(TimeShiftedEvent) func) {
    _addListener(func);
  }

  @override
  set onPlaybackFinished(void Function(PlaybackFinishedEvent) func) {
    _addListener(func);
  }

  @override
  set onSourceWarning(void Function(SourceWarningEvent) func) {
    _addListener(func);
  }

  @override
  set onSourceError(void Function(SourceErrorEvent) func) {
    _addListener(func);
  }

  @override
  set onSourceInfo(void Function(SourceInfoEvent) func) {
    _addListener(func);
  }

  @override
  set onError(void Function(ErrorEvent) func) {
    _addListener(func);
  }

  @override
  set onInfo(void Function(InfoEvent) func) {
    _addListener(func);
  }

  @override
  set onWarning(void Function(WarningEvent) func) {
    _addListener(func);
  }

  @override
  set onReady(void Function(ReadyEvent) func) {
    _addListener(func);
  }

  @override
  set onSubtitleAdded(void Function(SubtitleAddedEvent) func) {
    _addListener(func);
  }

  @override
  set onSubtitleRemoved(void Function(SubtitleRemovedEvent) func) {
    _addListener(func);
  }

  @override
  set onSubtitleChanged(void Function(SubtitleChangedEvent) func) {
    _addListener(func);
  }

  @override
  set onCueEnter(void Function(CueEnterEvent) func) {
    _addListener(func);
  }

  @override
  set onCueExit(void Function(CueExitEvent) func) {
    _addListener(func);
  }

  @override
  set onCastAvailable(void Function(CastAvailableEvent) func) {
    _addListener(func);
  }

  @override
  set onCastWaitingForDevice(void Function(CastWaitingForDeviceEvent) func) {
    _addListener(func);
  }

  @override
  set onCastStart(void Function(CastStartEvent) func) {
    _addListener(func);
  }

  @override
  set onCastStarted(void Function(CastStartedEvent) func) {
    _addListener(func);
  }

  @override
  set onCastStopped(void Function(CastStoppedEvent) func) {
    _addListener(func);
  }

  @override
  set onCastTimeUpdated(void Function(CastTimeUpdatedEvent) func) {
    _addListener(func);
  }

  @override
  set onAirPlayAvailable(void Function(AirPlayAvailableEvent) func) {
    _addListener(func);
  }

  @override
  set onAirPlayChanged(void Function(AirPlayChangedEvent) func) {
    _addListener(func);
  }

  @override
  set onPictureInPictureEnter(void Function(PictureInPictureEnterEvent) func) {
    _addListener(func);
  }

  @override
  set onPictureInPictureEntered(
    void Function(PictureInPictureEnteredEvent) func,
  ) {
    _addListener(func);
  }

  @override
  set onPictureInPictureExit(void Function(PictureInPictureExitEvent) func) {
    _addListener(func);
  }

  @override
  set onPictureInPictureExited(
    void Function(PictureInPictureExitedEvent) func,
  ) {
    _addListener(func);
  }
}
