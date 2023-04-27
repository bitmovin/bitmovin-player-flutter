import 'dart:convert';

import 'package:bitmovin_sdk/src/interfaces/player_event_interface.dart';

typedef Callback<T> = void Function(T data);

mixin PlayerEventListener implements PlayerEventsInterface {
  Callback<dynamic>? _onSourceLoad;
  Callback<dynamic>? _onSourceLoaded;
  Callback<dynamic>? _onSourceUnLoaded;
  Callback<dynamic>? _onPlay;
  Callback<dynamic>? _onPlaying;
  Callback<dynamic>? _onTimeChanged;
  Callback<dynamic>? _onPaused;
  Callback<dynamic>? _onMuted;
  Callback<dynamic>? _onUnmuted;
  Callback<dynamic>? _onSourceAdded;
  Callback<dynamic>? _onSourceRemoved;
  Callback<dynamic>? _onSeek;
  Callback<dynamic>? _onSeeked;
  Callback<dynamic>? _onPlaybackFinished;
  Callback<dynamic>? _onSourceError;
  Callback<dynamic>? _onSourceWarning;
  Callback<dynamic>? _onSourceInfo;
  Callback<dynamic>? _onError;
  Callback<dynamic>? _onWarning;
  Callback<dynamic>? _onInfo;
  Callback<dynamic>? _onReady;

  void onEvent(dynamic event) {
    final target = jsonDecode(event as String) as Map<String, dynamic>;
    final data = jsonDecode(target['data'] as String) as Map<String, dynamic>?;
    switch (target['event']) {
      case 'onSourceAdded':
        _onSourceAdded?.call(data);
        break;
      case 'onSourceRemoved':
        _onSourceRemoved?.call(data);
        break;
      case 'onSourceLoad':
        _onSourceLoad?.call(data);
        break;
      case 'onSourceLoaded':
        _onSourceLoaded?.call(data);
        break;
      case 'onSourceUnLoaded':
        _onSourceUnLoaded?.call(data);
        break;
      case 'onSourceWarning':
        _onSourceWarning?.call(data);
        break;
      case 'onSourceError':
        _onSourceError?.call(data);
        break;
      case 'onSourceInfo':
        _onSourceInfo?.call(data);
        break;
      case 'onTimeChanged':
        _onTimeChanged?.call(data);
        break;
      case 'onPlay':
        _onPlay?.call(data);
        break;
      case 'onPlaying':
        _onPlaying?.call(data);
        break;
      case 'onPaused':
        _onPaused?.call(data);
        break;
      case 'onMuted':
        _onMuted?.call(data);
        break;
      case 'onUnmuted':
        _onUnmuted?.call(data);
        break;
      case 'onSeeked':
        _onSeeked?.call(data);
        break;
      case 'onSeek':
        _onSeek?.call(data);
        break;
      case 'onPlaybackFinished':
        _onPlaybackFinished?.call(data);
        break;
      case 'onError':
        _onError?.call(data);
        break;
      case 'onInfo':
        _onInfo?.call(data);
        break;
      case 'onWarning':
        _onWarning?.call(data);
        break;
      case 'onReady':
        _onReady?.call(data);
        break;
    }
  }

  @override
  set onTimeChanged(void Function(dynamic data) func) {
    _onTimeChanged = func;
  }

  @override
  set onLoad(void Function(dynamic data) func) {
    _onSourceLoad = func;
  }

  @override
  set onLoaded(void Function(dynamic data) func) {
    _onSourceLoaded = func;
  }

  @override
  set onSourceUnLoaded(void Function(dynamic data) func) {
    _onSourceUnLoaded = func;
  }

  @override
  set onPlay(void Function(dynamic data) func) {
    _onPlay = func;
  }

  @override
  set onPlaying(void Function(dynamic data) func) {
    _onPlaying = func;
  }

  @override
  set onPaused(void Function(dynamic data) func) {
    _onPaused = func;
  }

  @override
  set onMuted(void Function(dynamic data) func) {
    _onMuted = func;
  }

  @override
  set onUnMuted(void Function(dynamic data) func) {
    _onUnmuted = func;
  }

  @override
  set onSourceAdded(void Function(dynamic data) func) {
    _onSourceAdded = func;
  }

  @override
  set onSourceRemoved(void Function(dynamic data) func) {
    _onSourceRemoved = func;
  }

  @override
  set onSeek(void Function(dynamic data) func) {
    _onSeek = func;
  }

  @override
  set onSeeked(void Function(dynamic data) func) {
    _onSeeked = func;
  }

  @override
  set onPlaybackFinished(void Function(dynamic data) func) {
    _onPlaybackFinished = func;
  }

  @override
  set onSourceWarning(void Function(dynamic data) func) {
    _onSourceWarning = func;
  }

  @override
  set onSourceError(void Function(dynamic data) func) {
    _onSourceError = func;
  }

  @override
  set onSourceInfo(void Function(dynamic data) func) {
    _onSourceInfo = func;
  }

  @override
  set onError(void Function(dynamic data) func) {
    _onError = func;
  }

  @override
  set onInfo(void Function(dynamic data) func) {
    _onInfo = func;
  }

  @override
  set onWarning(void Function(dynamic data) func) {
    _onWarning = func;
  }

  @override
  set onReady(void Function(dynamic data) func) {
    _onReady = func;
  }
}
