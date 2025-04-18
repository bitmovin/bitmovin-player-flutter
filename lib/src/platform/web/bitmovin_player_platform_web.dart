import 'dart:ui_web' as ui;

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/channels.dart';
import 'package:bitmovin_player/src/platform/bitmovin_player_platform_interface.dart';
import 'package:bitmovin_player/src/platform/cast_manager_platform_interface.dart';
import 'package:bitmovin_player/src/platform/player_platform_interface.dart';
import 'package:bitmovin_player/src/platform/player_view_platform_interface.dart';
import 'package:bitmovin_player/src/platform/web/cast_manager_platform_web.dart';
import 'package:bitmovin_player/src/platform/web/player_platform_web.dart';
import 'package:bitmovin_player/src/platform/web/player_view_platform_web.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:web/web.dart' as web;

/// Implementation of the [BitmovinPlayerPlatformInterface] for the Web
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
    CastManagerPlatformInterface.instance = CastManagerPlatformWeb();
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
  web.Element _viewFactory(int viewId, {Object? params}) {
    final playerId = (params as dynamic)['playerId'] as String;
    final wrapperId = 'player-wrapper-$playerId';
    final playerWrapper = web.document.createElement('div')..id = wrapperId;

    final player =
        web.document.getElementById('player-$playerId') as web.HTMLDivElement?;
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
