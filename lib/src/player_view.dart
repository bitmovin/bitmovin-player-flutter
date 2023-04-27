import 'dart:io';

import 'package:bitmovin_sdk/src/channel_manager.dart';
import 'package:bitmovin_sdk/src/player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

typedef PlayerCallback = void Function();

class PlayerView extends StatefulWidget {
  const PlayerView({
    super.key,
    this.player,
    this.onViewCreated,
  });
  final Player? player;
  final PlayerCallback? onViewCreated;

  @override
  State<StatefulWidget> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  late final MethodChannel _methodChannel;
  final ChannelManager _channelManager = ChannelManager();

  @override
  void initState() {
    _channelManager.method.invokeMethod(
      'CREATE_PLAYER_VIEW',
      Map<String, dynamic>.from({
        'playerId': widget.player?.id,
      }),
    );
    super.initState();
  }

  void _onPlatformViewCreated(int id) {
    _methodChannel = MethodChannel('player-view-$id');

    if (widget.player != null) {
      _methodChannel.invokeMethod(
        'BIND_PLAYER',
        Map<String, dynamic>.from({
          'playerId': widget.player!.id,
          'viewId': id,
        }),
      );
    }

    widget.onViewCreated?.call();
  }

  @override
  void dispose() {
    if (widget.player != null) {
      _methodChannel.invokeMethod(
        'UNBIND_PLAYER',
        Map<String, dynamic>.from({
          'playerId': widget.player!.id,
        }),
      );
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? PlatformViewLink(
            viewType: 'player-view',
            surfaceFactory: (context, controller) {
              return AndroidViewSurface(
                controller: controller as ExpensiveAndroidViewController,
                gestureRecognizers: const <
                    Factory<OneSequenceGestureRecognizer>>{},
                hitTestBehavior: PlatformViewHitTestBehavior.opaque,
              );
            },
            onCreatePlatformView: (PlatformViewCreationParams params) {
              return PlatformViewsService.initExpensiveAndroidView(
                id: params.id,
                viewType: 'player-view',
                layoutDirection: TextDirection.ltr,
                creationParams: widget.player?.id,
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
            viewType: 'player-view',
            layoutDirection: TextDirection.ltr,
            creationParams: widget.player?.id,
            onPlatformViewCreated: _onPlatformViewCreated,
            creationParamsCodec: const StandardMessageCodec(),
          );
  }
}
