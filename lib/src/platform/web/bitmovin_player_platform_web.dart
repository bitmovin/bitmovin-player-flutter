// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:ui_web' as ui;

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/channels.dart';
import 'package:bitmovin_player/src/platform/bitmovin_player_platform_interface.dart';
import 'package:bitmovin_player/src/platform/player_platform_interface.dart';
import 'package:bitmovin_player/src/platform/player_view_platform_interface.dart';
import 'package:bitmovin_player/src/platform/web/player_platform_web.dart';
import 'package:bitmovin_player/src/platform/web/player_view_platform_web.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// Implementation of the [BitmovinPlayerPlatformInterface] for the web
/// platform.
class BitmovinPlayerPlatformWeb extends BitmovinPlayerPlatformInterface {
  /// Constructs a [BitmovinPlayerPlatformWeb].
  BitmovinPlayerPlatformWeb() {
    ui.platformViewRegistry.registerViewFactory(
      Channels.playerView,
      _viewFactory,
    );
  }

  static void registerWith(Registrar registrar) {
    BitmovinPlayerPlatformInterface.instance = BitmovinPlayerPlatformWeb();
  }

  @override
  PlayerPlatformInterface createPlayer(
    String id,
    PlayerConfig config,
    void Function(Event event) onPlatformEvent,
  ) {
    return PlayerPlatformWeb(id, config, onPlatformEvent);
  }

  @override
  PlayerViewPlatformInterface createPlayerView({
    required void Function(Event event) onPlatformEvent,
    required void Function() handleEnterFullscreen,
    required void Function() handleExitFullscreen,
    void Function()? onViewCreated,
  }) {
    return PlayerViewPlatformWeb(
      handleEnterFullscreen,
      handleExitFullscreen,
      onViewCreated,
    );
  }

  /// Creates a player view. By the time of calling, a player instance already
  /// exists and is ready to be used. It can be accessed through DOM by its ID.
  Element _viewFactory(int viewId, {Object? params}) {
    final playerId = (params as dynamic)['playerId'] as String;
    final wrapperId = 'player-wrapper-$playerId';
    final playerWrapper = document.createElement('div')..id = wrapperId;

    final player = document.getElementById('player-$playerId');
    if (player == null) {
      throw Exception(
        "Player DOM element with id 'player-$playerId' not found",
      );
    }

    player.style.visibility = 'visible';
    playerWrapper.append(player);

    return playerWrapper;
  }
}
