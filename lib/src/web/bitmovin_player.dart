// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:async';
import 'dart:html';
import 'dart:ui_web' as ui;

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/channels.dart';
import 'package:bitmovin_player/src/platform/bitmovin_player_platform_interface.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// A web implementation of the BitmovinPlayerPlatform of the BitmovinPlayer
/// plugin.
class BitmovinPlayerWeb extends BitmovinPlayerPlatform {
  /// Constructs a BitmovinPlayerWeb
  BitmovinPlayerWeb() {
    ui.platformViewRegistry.registerViewFactory(Channels.playerView,
        (int viewId, {Object? params}) {
      final div = document.createElement('div') as DivElement
        ..id = (params as dynamic)['playerId'] as String
        ..style.width = '100%'
        ..style.height = '100%'
        ..className = 'bitmovinplayer';
      // TODO(mario): set player on view

      return div;
    });
  }

  static void registerWith(Registrar registrar) {
    BitmovinPlayerPlatform.instance = BitmovinPlayerWeb();
  }

  @override
  Future<bool> createPlayer(String id, PlayerConfig config) async {
    // TODO(mario): Implement createPlayer for web.
    return true;
  }
}
