import 'package:bitmovin_player/bitmovin_player.dart';

/// The subtitle file formats that can be used to create a side-loaded
/// [SubtitleTrack]. Please note that not all formats are supported on all
/// platforms. Check the documentation for each constant for more information.
class SubtitleFormats {
  static const _baseTypeText = 'text';
  static const _baseTypeApplication = 'application';

  /// Available on Android and iOS.
  static const vtt = '$_baseTypeText/vtt';

  /// Available on Android.
  static const ssa = '$_baseTypeText/x-ssa';
  static const ttml = '$_baseTypeApplication/ttml+xml';
  static const mp4vtt = '$_baseTypeApplication/x-mp4-vtt';
  static const subrip = '$_baseTypeApplication/x-subrip';
  static const tx3g = '$_baseTypeApplication/x-quicktime-tx3g';
  static const cea608 = '$_baseTypeApplication/cea-608';
  static const cea708 = '$_baseTypeApplication/cea-708';
  static const mp4cea608 = '$_baseTypeApplication/x-mp4-cea-608';
  static const dvbsubs = '$_baseTypeApplication/dvbsubs';
}
