import 'dart:convert';
import 'package:bitmovin_player/bitmovin_player.dart';

typedef Callback<T> = void Function(T data);

mixin PlayerEventListener implements PlayerEventsInterface {
  Callback<SourceErrorEvent>? _onSourceError;
  Callback<SourceWarningEvent>? _onSourceWarning;
  Callback<SourceInfoEvent>? _onSourceInfo;
  Callback<SourceLoadEvent>? _onSourceLoad;
  Callback<SourceLoadedEvent>? _onSourceLoaded;
  Callback<SourceUnloadedEvent>? _onSourceUnloaded;
  Callback<SourceAddedEvent>? _onSourceAdded;
  Callback<SourceRemovedEvent>? _onSourceRemoved;

  Callback<PlayEvent>? _onPlay;
  Callback<PlayingEvent>? _onPlaying;
  Callback<TimeChangedEvent>? _onTimeChanged;
  Callback<PausedEvent>? _onPaused;
  Callback<MutedEvent>? _onMuted;
  Callback<UnmutedEvent>? _onUnmuted;
  Callback<SeekEvent>? _onSeek;
  Callback<SeekedEvent>? _onSeeked;
  Callback<PlaybackFinishedEvent>? _onPlaybackFinished;
  Callback<ReadyEvent>? _onReady;
  Callback<ErrorEvent>? _onError;
  Callback<WarningEvent>? _onWarning;
  Callback<InfoEvent>? _onInfo;

  void onEvent(dynamic event) {
    if (event == null) {
      // TODO(mario): log error and debug all runtime occurrences as
      // this should not happen.
      return;
    }

    final target = jsonDecode(event as String) as Map<String, dynamic>;

    if (target['data'] == null || target['data'] is! String) {
      // TODO(mario): log error and debug all runtime occurrences as
      // this should not happen.
      return;
    }

    final data = jsonDecode(target['data'] as String) as Map<String, dynamic>?;

    switch (target['event']) {
      case 'onSourceAdded':
        if (data != null) {
          _onSourceAdded?.call(SourceAddedEvent.fromJson(data));
        }
        break;
      case 'onSourceRemoved':
        if (data != null) {
          _onSourceRemoved?.call(SourceRemovedEvent.fromJson(data));
        }
        break;
      case 'onSourceLoad':
        if (data != null) {
          _onSourceLoad?.call(SourceLoadEvent.fromJson(data));
        }
        break;
      case 'onSourceLoaded':
        if (data != null) {
          _onSourceLoaded?.call(SourceLoadedEvent.fromJson(data));
        }
        break;
      case 'onSourceUnloaded':
        if (data != null) {
          _onSourceUnloaded?.call(SourceUnloadedEvent.fromJson(data));
        }
        break;
      case 'onSourceWarning':
        if (data != null) {
          _onSourceWarning?.call(SourceWarningEvent.fromJson(data));
        }
        break;
      case 'onSourceError':
        if (data != null) {
          _onSourceError?.call(SourceErrorEvent.fromJson(data));
        }
        break;
      case 'onSourceInfo':
        if (data != null) {
          _onSourceInfo?.call(SourceInfoEvent.fromJson(data));
        }
        break;
      case 'onTimeChanged':
        if (data != null) {
          _onTimeChanged?.call(TimeChangedEvent.fromJson(data));
        }
        break;
      case 'onPlay':
        if (data != null) {
          _onPlay?.call(PlayEvent.fromJson(data));
        }
        break;
      case 'onPlaying':
        if (data != null) {
          _onPlaying?.call(PlayingEvent.fromJson(data));
        }
        break;
      case 'onPaused':
        if (data != null) {
          _onPaused?.call(PausedEvent.fromJson(data));
        }
        break;
      case 'onMuted':
        if (data != null) {
          _onMuted?.call(MutedEvent.fromJson(data));
        }
        break;
      case 'onUnmuted':
        if (data != null) {
          _onUnmuted?.call(UnmutedEvent.fromJson(data));
        }
        break;
      case 'onSeeked':
        if (data != null) {
          _onSeeked?.call(SeekedEvent.fromJson(data));
        }
        break;
      case 'onSeek':
        if (data != null) {
          _onSeek?.call(SeekEvent.fromJson(data));
        }
        break;
      case 'onPlaybackFinished':
        if (data != null) {
          _onPlaybackFinished?.call(PlaybackFinishedEvent.fromJson(data));
        }
        break;
      case 'onPlayerError':
        if (data != null) {
          _onError?.call(ErrorEvent.fromJson(data));
        }
        break;
      case 'onPlayerInfo':
        if (data != null) {
          _onInfo?.call(InfoEvent.fromJson(data));
        }
        break;
      case 'onPlayerWarning':
        if (data != null) {
          _onWarning?.call(WarningEvent.fromJson(data));
        }
        break;
      case 'onReady':
        if (data != null) {
          _onReady?.call(ReadyEvent.fromJson(data));
        }
        break;
    }
  }

  @override
  set onTimeChanged(void Function(TimeChangedEvent data) func) {
    _onTimeChanged = func;
  }

  @override
  set onSourceLoad(void Function(SourceLoadEvent data) func) {
    _onSourceLoad = func;
  }

  @override
  set onSourceLoaded(void Function(SourceLoadedEvent data) func) {
    _onSourceLoaded = func;
  }

  @override
  set onSourceUnloaded(void Function(SourceUnloadedEvent data) func) {
    _onSourceUnloaded = func;
  }

  @override
  set onPlay(void Function(PlayEvent data) func) {
    _onPlay = func;
  }

  @override
  set onPlaying(void Function(PlayingEvent data) func) {
    _onPlaying = func;
  }

  @override
  set onPaused(void Function(PausedEvent data) func) {
    _onPaused = func;
  }

  @override
  set onMuted(void Function(MutedEvent data) func) {
    _onMuted = func;
  }

  @override
  set onUnmuted(void Function(UnmutedEvent data) func) {
    _onUnmuted = func;
  }

  @override
  set onSourceAdded(void Function(SourceAddedEvent data) func) {
    _onSourceAdded = func;
  }

  @override
  set onSourceRemoved(void Function(SourceRemovedEvent data) func) {
    _onSourceRemoved = func;
  }

  @override
  set onSeek(void Function(SeekEvent data) func) {
    _onSeek = func;
  }

  @override
  set onSeeked(void Function(SeekedEvent data) func) {
    _onSeeked = func;
  }

  @override
  set onPlaybackFinished(void Function(PlaybackFinishedEvent data) func) {
    _onPlaybackFinished = func;
  }

  @override
  set onSourceWarning(void Function(SourceWarningEvent data) func) {
    _onSourceWarning = func;
  }

  @override
  set onSourceError(void Function(SourceErrorEvent data) func) {
    _onSourceError = func;
  }

  @override
  set onSourceInfo(void Function(SourceInfoEvent data) func) {
    _onSourceInfo = func;
  }

  @override
  set onError(void Function(ErrorEvent data) func) {
    _onError = func;
  }

  @override
  set onInfo(void Function(InfoEvent data) func) {
    _onInfo = func;
  }

  @override
  set onWarning(void Function(WarningEvent data) func) {
    _onWarning = func;
  }

  @override
  set onReady(void Function(ReadyEvent data) func) {
    _onReady = func;
  }
}
