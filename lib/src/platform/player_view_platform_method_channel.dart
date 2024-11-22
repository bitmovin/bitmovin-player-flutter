import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/channel_manager.dart';
import 'package:bitmovin_player/src/channels.dart';
import 'package:bitmovin_player/src/methods.dart';
import 'package:bitmovin_player/src/platform.dart';
import 'package:bitmovin_player/src/platform/event_deserializer.dart';
import 'package:bitmovin_player/src/platform/player_view_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class PlayerViewPlatformMethodChannel extends PlayerViewPlatformInterface {
  PlayerViewPlatformMethodChannel(
    this._onPlatformEvent,
    this._handleEnterFullscreen,
    this._handleExitFullscreen,
    this._onViewCreated,
  );

  final void Function(Event event) _onPlatformEvent;
  final void Function() _handleEnterFullscreen;
  final void Function() _handleExitFullscreen;
  final void Function()? _onViewCreated;
  final EventDeserializer _eventDeserializer = EventDeserializer();
  late final MethodChannel _methodChannel;
  late final EventChannel _eventChannel;

  @override
  Widget build(BuildContext context, Map<String, dynamic> creationParams) {
    if (isAndroid) {
      return _buildForAndroid(context, creationParams);
    } else if (isIOS) {
      return _buildForIos(context, creationParams);
    } else {
      throw UnsupportedError(
        'Cannot build player view widget: Unsupported platform.',
      );
    }
  }

  @override
  void dispose() => _invokeMethod<void>(Methods.destroyPlayerView);

  @override
  void enterFullscreen() {
    _invokeMethod<void>(Methods.enterFullscreen);
  }

  @override
  void exitFullscreen() {
    _invokeMethod<void>(Methods.exitFullscreen);
  }

  @override
  Future<void> enterPictureInPicture() async =>
      _invokeMethod<void>(Methods.enterPictureInPicture);

  @override
  Future<void> exitPictureInPicture() async =>
      _invokeMethod<void>(Methods.exitPictureInPicture);

  @override
  Future<bool> get isPictureInPicture async =>
      _invokeMethod<bool>(Methods.isPictureInPicture);

  @override
  Future<bool> get isPictureInPictureAvailable async =>
      _invokeMethod<bool>(Methods.isPictureInPictureAvailable);

  // Can be used to call methods on the platform side that return a single
  // primitive value that is natively supported by the method channel.
  Future<T> _invokeMethod<T>(
    String methodName, [
    dynamic data,
  ]) async {
    final result = await _methodChannel.invokeMethod<T>(methodName, data);
    if (result is! T) {
      // result is T?, if it `is` not T => T is not nullable and result is null.
      throw Exception('Native $methodName returned null.');
    }
    return result;
  }

  void _onPlatformViewCreated(int id) {
    _methodChannel = ChannelManager.registerMethodChannel(
      name: '${Channels.playerView}-$id',
      handler: _playerViewMethodCallHandler,
    );
    _eventChannel = ChannelManager.registerEventChannel(
      name: '${Channels.playerViewEvent}-$id',
    );
    _eventChannel.receiveBroadcastStream().listen((dynamic eventPayload) {
      final event = _eventDeserializer.deserialize(eventPayload);
      if (event != null) {
        _onPlatformEvent(event);
      }
    });
    _onViewCreated?.call();
  }

  Future<dynamic> _playerViewMethodCallHandler(MethodCall methodCall) {
    switch (methodCall.method) {
      case Methods.enterFullscreen:
        _handleEnterFullscreen();
        break;
      case Methods.exitFullscreen:
        _handleExitFullscreen();
        break;
      default:
        return Future.error(
          // ignore: lines_longer_than_80_chars
          'Unsupported method call ${methodCall.method} seen in _playerViewMethodCallHandler',
        );
    }

    return Future.value(true);
  }

  Widget _buildForAndroid(
    BuildContext context,
    Map<String, dynamic> creationParams,
  ) {
    return PlatformViewLink(
      viewType: Channels.playerView,
      surfaceFactory: (context, controller) {
        return AndroidViewSurface(
          controller: controller as ExpensiveAndroidViewController,
          gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        );
      },
      onCreatePlatformView: (PlatformViewCreationParams params) {
        return PlatformViewsService.initExpensiveAndroidView(
          id: params.id,
          viewType: Channels.playerView,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
          onFocus: () {
            params.onFocusChanged(true);
          },
        )
          ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
          ..addOnPlatformViewCreatedListener(_onPlatformViewCreated)
          ..create();
      },
    );
  }

  Widget _buildForIos(
    BuildContext context,
    Map<String, dynamic> creationParams,
  ) {
    return UiKitView(
      viewType: Channels.playerView,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      onPlatformViewCreated: _onPlatformViewCreated,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
