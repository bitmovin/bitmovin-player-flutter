import 'dart:io';

import 'package:bitmovin_sdk/player.dart';
import 'package:bitmovin_sdk/src/channels.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

typedef PlayerCreatedCallback = void Function(PlayerController controller);
typedef EventHandler = void Function(dynamic value);

class PlayerView extends StatefulWidget {
  const PlayerView({
    required this.onPlayerCreated,
    super.key,
    this.playerConfig,
    // this.sourceConfig,
  });

  final PlayerCreatedCallback onPlayerCreated;

  // final SourceConfig? sourceConfig;

  final PlayerConfig? playerConfig;

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  final stream = const EventChannel(Channels.events);

  // Map<String, dynamic>? buildSourceConfig(String? url) {
  //   if (url != null) {
  //     return SourceConfig(url: url, type: SourceType.dash).toJson();
  //   }
  //   return widget.sourceConfig?.toJson();
  // }

  /// Creates the required parameters to be use by the Native Code.
  Map<String, dynamic> _buildParams() {
    return <String, dynamic>{
      // 'sourceConfig': widget.sourceConfig?.toJson(),
      'playerConfig': widget.playerConfig!.toJson(),
    };
  }

  void _startListener() {
    stream.receiveBroadcastStream().listen(_listenStream);
  }

  void _listenStream(dynamic value) {
    debugPrint('Received From Native:  $value\n');
    // widget.eventHandler?.call(value);
  }

  /// [id] parameter is the native view id that can be use to identify the view
  /// from the native view.
  void _onPlatformViewCreated(int id) {
    widget.onPlayerCreated(PlayerController(id: id));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? PlatformViewLink(
            viewType: Channels.type,
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
                viewType: Channels.type,
                layoutDirection: TextDirection.ltr,
                creationParams: _buildParams(),
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
            viewType: Channels.type,
            layoutDirection: TextDirection.ltr,
            creationParams: _buildParams(),
            onPlatformViewCreated: _onPlatformViewCreated,
            creationParamsCodec: const StandardMessageCodec(),
          );
  }
}
