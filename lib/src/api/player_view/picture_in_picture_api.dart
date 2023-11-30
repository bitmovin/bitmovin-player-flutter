import 'package:bitmovin_player/bitmovin_player.dart';

/// Provides an API to interact with the Picture-in-Picture mode of a
/// [PlayerView].
abstract class PictureInPictureAPI {
  /// Returns whether the [PlayerView] is currently in Picture-in-Picture (PiP)
  /// mode.
  Future<bool> get isPictureInPicture;

  /// Returns if Picture-In-Picture is available.
  ///
  /// Picture-In-Picture is available in the following use-cases:
  /// - on iOS 14.2 and above. (We disabled PiP on iOS 14.0 and 14.1 due to an
  /// underlying iOS bug)
  /// - on tvOS 14 and above.
  /// - if explicitly enabled through
  /// `PlaybackConfiguration#isPictureInPictureEnabled` (default is disabled)
  Future<bool> get isPictureInPictureAvailable;

  /// The [PlayerView] enters Picture-In-Picture mode.
  /// Has no effects if already in Picture-In-Picture.
  /// - Starting Picture-In-Picture during casting is not supported and will
  /// result in a no-op.
  /// - This has no effect when using system UI.
  Future<void> enterPictureInPicture();

  /// The [PlayerView] exits Picture-In-Picture mode.
  /// Has no effect if not in Picture-In-Picture mode.
  ///
  /// This has no effect when using system UI.
  Future<void> exitPictureInPicture();
}
