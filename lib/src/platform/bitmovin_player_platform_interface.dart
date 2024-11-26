import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:bitmovin_player/src/platform/bitmovin_player_platform_method_channel.dart';
import 'package:bitmovin_player/src/platform/player_platform_interface.dart';
import 'package:bitmovin_player/src/platform/player_view_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// The main platform interface that is used to interact with the platform
/// plugins. This is not specific to a player or player view instance.
abstract class BitmovinPlayerPlatformInterface extends PlatformInterface {
  /// Constructs a [BitmovinPlayerPlatformInterface].
  BitmovinPlayerPlatformInterface() : super(token: _token);

  static final Object _token = Object();

  static BitmovinPlayerPlatformInterface _instance =
      BitmovinPlayerPlatformMethodChannel();

  /// The instance of [BitmovinPlayerPlatformInterface] to use.
  ///
  /// Defaults to [BitmovinPlayerPlatformMethodChannel].
  static BitmovinPlayerPlatformInterface get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BitmovinPlayerPlatformInterface]
  /// when they register themselves.
  static set instance(BitmovinPlayerPlatformInterface instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Creates a new platform specific player instance with the given [id] and
  /// [config]. The [onPlatformEvent] callback is called by the platform
  /// implementation when a player event occurs.
  PlayerPlatformInterface createPlayer(
    String id,
    PlayerConfig config,
    void Function(Event event) onPlatformEvent,
  ) {
    throw UnimplementedError('createPlayer() has not been implemented.');
  }

  /// Creates a new platform specific player view instance.
  /// The [onPlatformEvent] callback is called by the platform implementation
  /// when a player view event occurs.
  /// The [handleEnterFullscreen] and [handleExitFullscreen] callbacks are
  /// called by the platform implementation whenever fullscreen is about to be
  /// entered or exited. Those calls are forwarded to the [FullscreenHandler]
  /// that might be present on the [PlayerView] widget.
  /// The [onViewCreated] callback is called by the platform implementation
  /// once the platform view was created successfully.
  PlayerViewPlatformInterface createPlayerView({
    required void Function(Event event) onPlatformEvent,
    required void Function() handleEnterFullscreen,
    required void Function() handleExitFullscreen,
    void Function()? onViewCreated,
  }) {
    throw UnimplementedError('createPlayerView() has not been implemented.');
  }
}
