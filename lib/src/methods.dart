class Methods {
  /// Player related methods
  static const String createPlayer = 'createPlayer';
  static const String loadWithSourceConfig = 'loadWithSourceConfig';
  static const String loadWithSource = 'loadWithSource';
  static const String unload = 'unload';
  static const String play = 'play';
  static const String pause = 'pause';
  static const String mute = 'mute';
  static const String unmute = 'unmute';
  static const String seek = 'seek';
  static const String currentTime = 'currentTime';
  static const String duration = 'duration';
  static const String destroy = 'destroy';
  static const String setTimeShift = 'setTimeShift';
  static const String getTimeShift = 'getTimeShift';
  static const String maxTimeShift = 'maxTimeShift';
  static const String isLive = 'isLive';
  static const String isPlaying = 'isPlaying';
  static const String isPaused = 'isPaused';
  static const String isMuted = 'isMuted';
  static const String sendCustomDataEvent = 'sendCustomDataEvent';
  static const String availableSubtitles = 'availableSubtitles';
  static const String setSubtitle = 'setSubtitle';
  static const String getSubtitle = 'getSubtitle';
  static const String removeSubtitle = 'removeSubtitle';
  static const String isCastAvailable = 'isCastAvailable';
  static const String isCasting = 'isCasting';
  static const String castVideo = 'castVideo';
  static const String castStop = 'castStop';
  static const String isAirPlayActive = 'isAirPlayActive';
  static const String isAirPlayAvailable = 'isAirPlayAvailable';
  static const String showAirPlayTargetPicker = 'showAirPlayTargetPicker';

  /// Player view related methods
  static const String destroyPlayerView = 'destroyPlayerView';
  static const String enterFullscreen = 'enterFullscreen';
  static const String exitFullscreen = 'exitFullscreen';
  static const String isPictureInPicture = 'isPictureInPicture';
  static const String isPictureInPictureAvailable =
      'isPictureInPictureAvailable';
  static const String enterPictureInPicture = 'enterPictureInPicture';
  static const String exitPictureInPicture = 'exitPictureInPicture';

  /// Fairplay DRM related methods
  static const String fairplayPrepareMessage = 'fairplayPrepareMessage';
  static const String fairplayPrepareContentId = 'fairplayPrepareContentId';
  static const String fairplayPrepareCertificate = 'fairplayPrepareCertificate';
  static const String fairplayPrepareLicense = 'fairplayPrepareLicense';
  static const String fairplayPrepareLicenseServerUrl =
      'fairplayPrepareLicenseServerUrl';
  static const String fairplayPrepareSyncMessage = 'fairplayPrepareSyncMessage';

  /// Widevine DRM related methods
  static const String widevinePrepareMessage = 'widevinePrepareMessage';
  static const String widevinePrepareLicense = 'widevinePrepareLicense';

  /// Bitmovin cast manager related methods
  static const String castManagerInitialize = 'castManagerInitialize';
  static const String castManagerSendMessage = 'castManagerSendMessage';
}
