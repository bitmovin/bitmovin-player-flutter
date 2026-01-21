import Foundation

internal enum Methods {
    // Player related methods
    static let createPlayer = "createPlayer"
    static let loadWithSourceConfig = "loadWithSourceConfig"
    static let loadWithSource = "loadWithSource"
    static let unload = "unload"
    static let play = "play"
    static let pause = "pause"
    static let mute = "mute"
    static let unmute = "unmute"
    static let seek = "seek"
    static let currentTime = "currentTime"
    static let duration = "duration"
    static let destroy = "destroy"
    static let setTimeShift = "setTimeShift"
    static let getTimeShift = "getTimeShift"
    static let maxTimeShift = "maxTimeShift"
    static let isLive = "isLive"
    static let isPlaying = "isPlaying"
    static let isPaused = "isPaused"
    static let isMuted = "isMuted"
    static let sendCustomDataEvent = "sendCustomDataEvent"
    static let availableSubtitles = "availableSubtitles"
    static let getSubtitle = "getSubtitle"
    static let setSubtitle = "setSubtitle"
    static let removeSubtitle = "removeSubtitle"
    static let isCastAvailable = "isCastAvailable"
    static let isCasting = "isCasting"
    static let castVideo = "castVideo"
    static let castStop = "castStop"
    static let isAirPlayActive = "isAirPlayActive"
    static let isAirPlayAvailable = "isAirPlayAvailable"
    static let showAirPlayTargetPicker = "showAirPlayTargetPicker"

    // Player view related methods
    static let destroyPlayerView = "destroyPlayerView"
    static let enterFullscreen = "enterFullscreen"
    static let exitFullscreen = "exitFullscreen"
    static let isPictureInPicture = "isPictureInPicture"
    static let isPictureInPictureAvailable = "isPictureInPictureAvailable"
    static let enterPictureInPicture = "enterPictureInPicture"
    static let exitPictureInPicture = "exitPictureInPicture"

    // Fairplay related methods
    static let fairplayPrepareMessage = "fairplayPrepareMessage"
    static let fairplayPrepareContentId = "fairplayPrepareContentId"
    static let fairplayPrepareCertificate = "fairplayPrepareCertificate"
    static let fairplayPrepareLicense = "fairplayPrepareLicense"
    static let fairplayPrepareLicenseServerUrl = "fairplayPrepareLicenseServerUrl"
    static let fairplayPrepareSyncMessage = "fairplayPrepareSyncMessage"

    // Cast related methods
    static let castManagerInitialize = "castManagerInitialize"
    static let castManagerSendMessage = "castManagerSendMessage"
}
