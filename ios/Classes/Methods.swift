import Foundation

internal enum Methods {
    // Player related methods
    static let createPlayer = "createPlayer"
    static let loadWithSourceConfig = "loadWithSourceConfig"
    static let loadWithSource = "loadWithSource"
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
    static let sendCustomDataEvent = "sendCustomDataEvent"
    static let availableSubtitles = "availableSubtitles"
    static let getSubtitle = "getSubtitle"
    static let setSubtitle = "setSubtitle"
    static let removeSubtitle = "removeSubtitle"

    // Player view related methods
    static let destroyPlayerView = "destroyPlayerView"
    static let enterFullscreen = "enterFullscreen"
    static let exitFullscreen = "exitFullscreen"

    // Fairplay related methods
    static let fairplayPrepareMessage = "fairplayPrepareMessage"
    static let fairplayPrepareContentId = "fairplayPrepareContentId"
    static let fairplayPrepareCertificate = "fairplayPrepareCertificate"
    static let fairplayPrepareLicense = "fairplayPrepareLicense"
    static let fairplayPrepareLicenseServerUrl = "fairplayPrepareLicenseServerUrl"
    static let fairplayPrepareSyncMessage = "fairplayPrepareSyncMessage"
}
