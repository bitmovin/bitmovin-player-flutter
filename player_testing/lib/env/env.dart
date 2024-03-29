import 'package:envied/envied.dart';

part 'env.g.dart';

/// Make sure to have a `.env` file inside `player_testing/` which contains the
/// bitmovin player license key as
/// `BITMOVIN_PLAYER_LICENSE_KEY=YOUR_LICENSE_KEY` where `YOUR_LICENSE_KEY`
/// is your private bitmovin player license key.
/// Then run `dart run build_runner build --delete-conflicting-outputs`
/// inside `player_testing` to generate the `env.g.dart` file.
@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'BITMOVIN_PLAYER_LICENSE_KEY')
  static const String bitmovinPlayerLicenseKey = _Env.bitmovinPlayerLicenseKey;
}
