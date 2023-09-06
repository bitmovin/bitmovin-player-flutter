import 'package:envied/envied.dart';

part 'env.g.dart';

/// Make sure to have a `.env` file in the project root (not inside `example/`)
/// which contains the bitmovin player license key as
/// `BITMOVIN_PLAYER_LICENSE_KEY=YOUR_LICENSE_KEY` where `YOUR_LICENSE_KEY`
/// is your private bitmovin player license key.
/// Optionally also add the `BITMOVIN_ANALYTICS_LICENSE_KEY=YOUR_LICENSE_KEY`
/// where `YOUR_LICENSE_KEY` is your private bitmovin analytics license key.
/// Then run `flutter pub run build_runner build --delete-conflicting-outputs`
/// in the project root to generate the `env.g.dart` file.
@Envied(path: '.env')
abstract class Env {
  static const String _unset = '__UNSET__';

  // default value of 'null' is not supported, so we have to work around it
  // and return null, in case the defaultValue is set;
  // this will enable us to check optional environment variables against null!
  static String? _getOptionalValue(String envValue) {
    if (envValue == _unset) {
      return null;
    }
    return envValue;
  }

  @EnviedField(varName: 'BITMOVIN_PLAYER_LICENSE_KEY')
  static const String bitmovinPlayerLicenseKey = _Env.bitmovinPlayerLicenseKey;

  @EnviedField(varName: 'BITMOVIN_ANALYTICS_LICENSE_KEY', defaultValue: _unset)
  static String? bitmovinAnalyticsLicenseKey =
      _getOptionalValue(_Env.bitmovinAnalyticsLicenseKey);
}
