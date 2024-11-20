// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

import 'dart:async';

import 'package:bitmovin_player/src/web/bitmovin_player_platform_interface.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// A web implementation of the BitmovinPlayerPlatform of the BitmovinPlayer
/// plugin.
class BitmovinPlayerWeb extends BitmovinPlayerPlatform {
  /// Constructs a BitmovinPlayerWeb
  BitmovinPlayerWeb();

  static void registerWith(Registrar registrar) {
    BitmovinPlayerPlatform.instance = BitmovinPlayerWeb();
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String?> getPlatformVersion() async {
    // final version = web.window.navigator.userAgent;
    // return version;
    return null;
  }
}
