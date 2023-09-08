import 'package:envied/envied.dart';

part 'env.g.dart';

/// Make sure to have a `.env` file in the project root (not inside
/// `player_testing/`) which contains the bitmovin player license key as
/// `BITMOVIN_PLAYER_LICENSE_KEY=YOUR_LICENSE_KEY` where `YOUR_LICENSE_KEY`
/// is your private bitmovin player license key.
/// Then run `flutter pub run build_runner build --delete-conflicting-outputs`
/// in the project root to generate the `env.g.dart` file.
@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'BITMOVIN_PLAYER_LICENSE_KEY')
  static const String bitmovinPlayerLicenseKey = _Env.bitmovinPlayerLicenseKey;
}
