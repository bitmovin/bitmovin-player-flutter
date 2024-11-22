import 'package:bitmovin_player/bitmovin_player.dart';

mixin PlayerEventHandler implements PlayerListener {
  final Map<String, List<void Function(Event)>> _eventListeners = {};

  /// Takes an [Event] and emits it to the corresponding event listener.
  void emitEvent(Event event) {
    final generalListener = _eventListeners[(Event).toString()];
    generalListener?.forEach((element) {
      element.call(event);
    });

    final listener = _eventListeners[event.runtimeType.toString()];
    listener?.forEach((element) {
      element.call(event);
    });
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
}
