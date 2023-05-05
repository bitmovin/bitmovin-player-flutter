import 'dart:convert';

import 'package:bitmovin_sdk/src/api/player_event.dart';
import 'package:bitmovin_sdk/src/api/source_event.dart';
import 'package:bitmovin_sdk/src/interfaces/player_event_interface.dart';

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
    final target = jsonDecode(event as String) as Map<String, dynamic>;
    final data = jsonDecode(target['data'] as String) as Map<String, dynamic>?;
    switch (target['event']) {
      case 'onSourceAdded':
        if (data != null) {
          _onSourceAdded?.call(SourceEvent.SourceAdded(data));
        }
        break;
      case 'onSourceRemoved':
        if (data != null) {
          _onSourceRemoved?.call(SourceEvent.SourceRemoved(data));
        }
        break;
      case 'onSourceLoad':
        if (data != null) {
          _onSourceLoad?.call(SourceEvent.Load(data));
        }
        break;
      case 'onSourceLoaded':
        if (data != null) {
          _onSourceLoaded?.call(SourceEvent.Loaded(data));
        }
        break;
      case 'onSourceUnloaded':
        if (data != null) {
          _onSourceUnloaded?.call(SourceEvent.Unloaded(data));
        }
        break;
      case 'onSourceWarning':
        if (data != null) {
          _onSourceWarning?.call(SourceEvent.SourceWarning(data));
        }
        break;
      case 'onSourceError':
        if (data != null) {
          _onSourceError?.call(SourceEvent.SourceError(data));
        }
        break;
      case 'onSourceInfo':
        if (data != null) {
          _onSourceInfo?.call(SourceEvent.SourceInfo(data));
        }
        break;
      case 'onTimeChanged':
        if (data != null) {
          _onTimeChanged?.call(PlayerEvent.TimeChanged(data));
        }
        break;
      case 'onPlay':
        if (data != null) {
          _onPlay?.call(PlayerEvent.Play(data));
        }
        break;
      case 'onPlaying':
        if (data != null) {
          _onPlaying?.call(PlayerEvent.Playing(data));
        }
        break;
      case 'onPaused':
        if (data != null) {
          _onPaused?.call(PlayerEvent.Paused(data));
        }
        break;
      case 'onMuted':
        if (data != null) {
          _onMuted?.call(PlayerEvent.Muted(data));
        }
        break;
      case 'onUnmuted':
        if (data != null) {
          _onUnmuted?.call(PlayerEvent.Unmuted(data));
        }
        break;
      case 'onSeeked':
        if (data != null) {
          _onSeeked?.call(PlayerEvent.Seeked(data));
        }
        break;
      case 'onSeek':
        if (data != null) {
          _onSeek?.call(PlayerEvent.Seek(data));
        }
        break;
      case 'onPlaybackFinished':
        if (data != null) {
          _onPlaybackFinished?.call(PlayerEvent.PlaybackFinished(data));
        }
        break;
      case 'onPlayerError':
        if (data != null) {
          _onError?.call(PlayerEvent.Error(data));
        }
        break;
      case 'onPlayerInfo':
        if (data != null) {
          _onInfo?.call(PlayerEvent.Info(data));
        }
        break;
      case 'onPlayerWarning':
        if (data != null) {
          _onWarning?.call(PlayerEvent.Warning(data));
        }
        break;
      case 'onReady':
        if (data != null) {
          _onReady?.call(PlayerEvent.Ready(data));
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
