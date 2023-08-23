import 'dart:convert';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:logger/logger.dart';

mixin PlayerEventHandler implements PlayerListener {
  final Logger _logger = Logger();
  final Map<String, void Function(Event)> _eventListeners = {};

  /// Takes an [Event] and emits it to the corresponding event listener.
  void emit(Event event) {
    final listener = _eventListeners[event.runtimeType.toString()];
    listener?.call(event);
  }

  /// Takes an event as JSON that was received from the native platform,
  /// deserializes it to a typed event object and emits it to the corresponding
  /// event listener.
  void onEvent(dynamic event) {
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
    }
  }

  void _setListener<T>(void Function(T) listener) {
    _eventListeners[T.toString()] = (Event event) {
      listener(event as T);
    };
  }

  @override
  set onTimeChanged(void Function(TimeChangedEvent) func) {
    _setListener(func);
  }

  @override
  set onSourceLoad(void Function(SourceLoadEvent) func) {
    _setListener(func);
  }

  @override
  set onSourceLoaded(void Function(SourceLoadedEvent) func) {
    _setListener(func);
  }

  @override
  set onSourceUnloaded(void Function(SourceUnloadedEvent) func) {
    _setListener(func);
  }

  @override
  set onPlay(void Function(PlayEvent) func) {
    _setListener(func);
  }

  @override
  set onPlaying(void Function(PlayingEvent) func) {
    _setListener(func);
  }

  @override
  set onPaused(void Function(PausedEvent) func) {
    _setListener(func);
  }

  @override
  set onMuted(void Function(MutedEvent) func) {
    _setListener(func);
  }

  @override
  set onUnmuted(void Function(UnmutedEvent) func) {
    _setListener(func);
  }

  @override
  set onSourceAdded(void Function(SourceAddedEvent) func) {
    _setListener(func);
  }

  @override
  set onSourceRemoved(void Function(SourceRemovedEvent) func) {
    _setListener(func);
  }

  @override
  set onSeek(void Function(SeekEvent) func) {
    _setListener(func);
  }

  @override
  set onSeeked(void Function(SeekedEvent) func) {
    _setListener(func);
  }

  @override
  set onTimeShift(void Function(TimeShiftEvent) func) {
    _setListener(func);
  }

  @override
  set onTimeShifted(void Function(TimeShiftedEvent) func) {
    _setListener(func);
  }

  @override
  set onPlaybackFinished(void Function(PlaybackFinishedEvent) func) {
    _setListener(func);
  }

  @override
  set onSourceWarning(void Function(SourceWarningEvent) func) {
    _setListener(func);
  }

  @override
  set onSourceError(void Function(SourceErrorEvent) func) {
    _setListener(func);
  }

  @override
  set onSourceInfo(void Function(SourceInfoEvent) func) {
    _setListener(func);
  }

  @override
  set onError(void Function(ErrorEvent) func) {
    _setListener(func);
  }

  @override
  set onInfo(void Function(InfoEvent) func) {
    _setListener(func);
  }

  @override
  set onWarning(void Function(WarningEvent) func) {
    _setListener(func);
  }

  @override
  set onReady(void Function(ReadyEvent) func) {
    _setListener(func);
  }
}
