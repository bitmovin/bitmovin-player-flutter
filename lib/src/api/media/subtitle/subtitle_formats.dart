import 'package:bitmovin_player/bitmovin_player.dart';

/// The subtitle file formats that can be used to create a side-loaded
/// [SubtitleTrack]. Please note that not all formats are supported on all
/// platforms. Check the documentation for each constant for more information.
class SubtitleFormats {
  /// Only available on iOS.
  static const String webVtt = 'webVtt';

  /// All following constants are only available on Android.
  static const String _baseTypeText = 'text';
  static const String _baseTypeApplication = 'application';
  static const String vtt = '$_baseTypeText/vtt';
  static const String ssa = '$_baseTypeText/x-ssa';
  static const String ttml = '$_baseTypeApplication/ttml+xml';
  static const String mp4vtt = '$_baseTypeApplication/x-mp4-vtt';
  static const String subrip = '$_baseTypeApplication/x-subrip';
  static const String tx3g = '$_baseTypeApplication/x-quicktime-tx3g';
  static const String cea608 = '$_baseTypeApplication/cea-608';
  static const String cea708 = '$_baseTypeApplication/cea-708';
  static const String mp4cea608 = '$_baseTypeApplication/x-mp4-cea-608';
  static const String dvbsubs = '$_baseTypeApplication/dvbsubs';
}
