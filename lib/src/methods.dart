class Methods {
  static const String createPlayer = 'create-player';
  static const String bindPlayer = 'bind-player';
  static const String unbindPlayer = 'unbind-player';
  static const String createPlayerView = 'create-player-view';

  /// Player related methods
  static const String loadWithSourceConfig = 'loadWithSourceConfig';
  static const String loadWithSource = 'loadWithSource';
  static const String play = 'play';
  static const String pause = 'pause';
  static const String mute = 'mute';
  static const String unmute = 'unmute';
  static const String seek = 'seek';
  static const String currentTime = 'currentTime';
  static const String duration = 'duration';
  static const String destroy = 'destroy';

  /// Fairplay DRM related methods
  static const String fairplayPrepareMessage = 'fairplayPrepareMessage';
  static const String fairplayPrepareContentId = 'fairplayPrepareContentId';
  static const String fairplayPrepareCertificate = 'fairplayPrepareCertificate';
  static const String fairplayPrepareLicense = 'fairplayPrepareLicense';
  static const String fairplayPrepareLicenseServerUrl =
      'fairplayPrepareLicenseServerUrl';
  static const String fairplayPrepareSyncMessage = 'fairplayPrepareSyncMessage';
}
