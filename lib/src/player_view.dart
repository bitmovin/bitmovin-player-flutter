import 'dart:io';

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/channel_manager.dart';
import 'package:bitmovin_player/src/channels.dart';
import 'package:bitmovin_player/src/methods.dart';
import 'package:bitmovin_player/src/player_view_event_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// A view that provides the Bitmovin Player Web UI and default UI handling to
/// an attached [Player] instance.
class PlayerView extends StatefulWidget with PlayerViewEventHandler {
  PlayerView({
    required this.player,
    super.key,
    this.playerViewConfig = const PlayerViewConfig(),
    this.onViewCreated,
    this.fullscreenHandler,
    this.onFullscreenEnter,
    this.onFullscreenExit,
    this.onPictureInPictureEnter,
    this.onPictureInPictureEntered,
    this.onPictureInPictureExit,
    this.onPictureInPictureExited,
  });

  /// The [Player] instance that is attached to this view.
  final Player player;

  /// The player view config.
  /// A default [PlayerViewConfig] is set initially
  final PlayerViewConfig playerViewConfig;

  /// Callback that is invoked when the view has been created and is ready to be
  /// used. Can be for instance used to load a source into the [player].
  final void Function()? onViewCreated;

  /// Handles entering and exiting fullscreen mode. A custom implementation
  /// needs to be provided that is aware of the view hierarchy where the
  /// [PlayerView] is embedded and can handle the UI state changes accordingly.
  /// If no [fullscreenHandler] is provided, the fullscreen feature is disabled.
  final FullscreenHandler? fullscreenHandler;

  @override
  final void Function(FullscreenEnterEvent)? onFullscreenEnter;

  @override
  final void Function(FullscreenExitEvent)? onFullscreenExit;

  @override
  final void Function(PictureInPictureEnterEvent)? onPictureInPictureEnter;

  @override
  final void Function(PictureInPictureEnteredEvent)? onPictureInPictureEntered;

  @override
  final void Function(PictureInPictureExitEvent)? onPictureInPictureExit;

  @override
  final void Function(PictureInPictureExitedEvent)? onPictureInPictureExited;

  @override
  State<StatefulWidget> createState() => PlayerViewState();
}

/// Provides the state for a [PlayerView].
class PlayerViewState extends State<PlayerView> {
  late final MethodChannel _methodChannel;
  late final EventChannel _eventChannel;

  void _onPlatformViewCreated(int id) {
    _methodChannel = ChannelManager.registerMethodChannel(
      name: '${Channels.playerView}-$id',
      handler: _playerViewMethodCallHandler,
    );
    _eventChannel = ChannelManager.registerEventChannel(
      name: '${Channels.playerViewEvent}-$id',
    );
    _eventChannel.receiveBroadcastStream().listen(widget.onEvent);

    widget.onViewCreated?.call();
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

  /// Returns whether the [PlayerView] is currently in fullscreen mode.
  bool get isFullscreen => widget.fullscreenHandler?.isFullscreen ?? false;

  /// Enters fullscreen mode for the [PlayerView].
  void enterFullscreen() {
    _invokeMethod<void>(Methods.enterFullscreen);
  }

  void _handleEnterFullscreen() {
    widget.fullscreenHandler?.enterFullscreen();
  }

  /// Exits fullscreen mode for the [PlayerView].
  void exitFullscreen() {
    _invokeMethod<void>(Methods.exitFullscreen);
  }

  void _handleExitFullscreen() {
    widget.fullscreenHandler?.exitFullscreen();
  }

  /// Access Picture-in-Picture APIs.
  PictureInPictureAPI get pictureInPicture => _PictureInPictureAPI(this);

  @override
  void dispose() {
    _invokeMethod<void>(Methods.destroyPlayerView);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final creationParams = {
      'playerId': widget.player.id,
      'hasFullscreenHandler': widget.fullscreenHandler != null,
      'isFullscreen': isFullscreen,
      'playerViewConfig': widget.playerViewConfig.toJson(),
    };

    return Platform.isAndroid
        ? PlatformViewLink(
            viewType: Channels.playerView,
            surfaceFactory: (context, controller) {
              return AndroidViewSurface(
                controller: controller as ExpensiveAndroidViewController,
                gestureRecognizers: const <Factory<
                    OneSequenceGestureRecognizer>>{},
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
          )
        : UiKitView(
            viewType: Channels.playerView,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            onPlatformViewCreated: _onPlatformViewCreated,
            creationParamsCodec: const StandardMessageCodec(),
          );
  }
}

class _PictureInPictureAPI implements PictureInPictureAPI {
  _PictureInPictureAPI(this._playerViewState);

  final PlayerViewState _playerViewState;

  /// Returns whether the [PlayerView] is currently in Picture-in-Picture (PiP)
  /// mode.
  @override
  Future<bool> get isPictureInPicture =>
      _playerViewState._invokeMethod<bool>(Methods.isPictureInPicture);

  /// Returns if Picture-In-Picture is available.
  ///
  /// Picture-In-Picture is available in the following use-cases:
  /// - on iOS 14.2 and above. (We disabled PiP on iOS 14.0 and 14.1 due to an
  /// underlying iOS bug)
  /// - on tvOS 14 and above.
  /// - if explicitly enabled through
  /// `PlaybackConfiguration#isPictureInPictureEnabled` (default is disabled)
  @override
  Future<bool> get isPictureInPictureAvailable async =>
      _playerViewState._invokeMethod<bool>(Methods.isPictureInPictureAvailable);

  /// The [PlayerView] enters Picture-In-Picture mode.
  /// Has no effects if already in Picture-In-Picture.
  /// - Starting Picture-In-Picture during casting is not supported and will
  /// result in a no-op.
  /// - This has no effect when using system UI.
  @override
  Future<void> enterPictureInPicture() async =>
      _playerViewState._invokeMethod<void>(Methods.enterPictureInPicture);

  /// The [PlayerView] exits Picture-In-Picture mode.
  /// Has no effect if not in Picture-In-Picture mode.
  ///
  /// This has no effect when using system UI.
  @override
  Future<void> exitPictureInPicture() =>
      _playerViewState._invokeMethod<void>(Methods.exitPictureInPicture);
}
