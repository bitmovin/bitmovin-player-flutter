import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/api/player/player_api.dart';
import 'package:bitmovin_player/src/drm/fairplay_handler.dart';
import 'package:bitmovin_player/src/drm/widevine_handler.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// The player platform interface that is used to interact with the platform
/// plugins. Manages a single player instance.
abstract class PlayerPlatformInterface extends PlatformInterface
    implements PlayerApi, AnalyticsApi {
  /// Constructs a [PlayerPlatformInterface].
  PlayerPlatformInterface() : super(token: Object());

  /// Handles Fairplay DRM related method calls.
  FairplayHandler? fairplayHandler;

  /// Handles Widevine DRM related method calls.
  WidevineHandler? widevineHandler;

  // ignore: avoid_positional_boolean_parameters
  void nativePlayerInitialized(bool? success);

  @override
  AnalyticsApi get analytics => _AnalyticsApi(this);

  @override
  Future<void> loadSourceConfig(
    SourceConfig sourceConfig,
  ) async {
    return loadSource(Source(sourceConfig: sourceConfig));
  }

  @override
  Future<void> loadSource(Source source) async {
    final fairplayConfig = source.sourceConfig.drmConfig?.fairplay;
    if (fairplayConfig != null) {
      fairplayHandler = FairplayHandler(fairplayConfig);
    }

    final widevineConfig = source.sourceConfig.drmConfig?.widevine;
    if (widevineConfig != null) {
      widevineHandler = WidevineHandler(widevineConfig);
    }
  }
}

class _AnalyticsApi implements AnalyticsApi {
  _AnalyticsApi(this._playerPlatformInterface);

  final PlayerPlatformInterface _playerPlatformInterface;

  @override
  Future<void> sendCustomDataEvent(CustomData customData) async =>
      _playerPlatformInterface.sendCustomDataEvent(customData);
}
