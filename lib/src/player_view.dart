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
    this.onViewCreated,
    this.fullscreenHandler,
    this.onFullscreenEnter,
    this.onFullscreenExit,
  });

  /// The [Player] instance that is attached to this view.
  final Player player;

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

  /// Returns whether the [PlayerView] is currently in fullscreen mode.
  bool get isFullscreen => widget.fullscreenHandler?.isFullscreen ?? false;

  /// Enters fullscreen mode for the [PlayerView].
  void enterFullscreen() {
    _methodChannel.invokeMethod(Methods.enterFullscreen);
  }

  void _handleEnterFullscreen() {
    widget.fullscreenHandler?.enterFullscreen();
  }

  /// Exits fullscreen mode for the [PlayerView].
  void exitFullscreen() {
    _methodChannel.invokeMethod(Methods.exitFullscreen);
  }

  void _handleExitFullscreen() {
    widget.fullscreenHandler?.exitFullscreen();
  }

  @override
  void dispose() {
    _methodChannel.invokeMethod(Methods.destroyPlayerView);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final creationParams = {
      'playerId': widget.player.id,
      'hasFullscreenHandler': widget.fullscreenHandler != null,
      'isFullscreen': isFullscreen,
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
