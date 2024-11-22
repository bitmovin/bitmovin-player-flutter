// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:ui_web' as ui;

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/channels.dart';
import 'package:bitmovin_player/src/platform/bitmovin_player_platform_interface.dart';
import 'package:bitmovin_player/src/platform/player_platform_interface.dart';
import 'package:bitmovin_player/src/platform/web/player_platform_web.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// A web implementation of the BitmovinPlayerPlatform of the BitmovinPlayer
/// plugin.
class BitmovinPlayerPlatformWeb extends BitmovinPlayerPlatformInterface {
  /// Constructs a BitmovinPlayerWeb
  BitmovinPlayerPlatformWeb() {
    ui.platformViewRegistry.registerViewFactory(
      Channels.playerView,
      viewFactory,
    );
  }

  static void registerWith(Registrar registrar) {
    BitmovinPlayerPlatformInterface.instance = BitmovinPlayerPlatformWeb();
  }

  Element viewFactory(int viewId, {Object? params}) {
    final playerId = (params as dynamic)['playerId'] as String;
    final containerId = 'player-wrapper-$playerId';
    final div = document.createElement('div')..id = containerId;

    final playerDiv = document.getElementById('player-$playerId');
    if (playerDiv == null) {
      throw Exception('Player div with id player-$playerId not found');
    }

    playerDiv.style.visibility = 'visible';
    div.append(playerDiv);

    return div;
  }

  @override
  PlayerPlatformInterface createPlayer(
    String id,
    PlayerConfig config,
    void Function(Event event) onPlatformEvent,
  ) {
    return PlayerPlatformWeb(id, config, onPlatformEvent);
  }
}
