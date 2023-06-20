import Foundation

class Methods {
    static let createPlayer = "create-player"
    static let bindPlayer = "bind-player"
    static let unbindPlayer = "unbind-player"
    static let createPlayerView = "create-player-view"

    // Player related methods
    static let loadWithSourceConfig = "loadWithSourceConfig"
    static let loadWithSource = "loadWithSource"
    static let play = "play"
    static let pause = "pause"
    static let mute = "mute"
    static let unmute = "unmute"
    static let seek = "seek"
    static let currentTime = "current_time"
    static let duration = "duration"
    static let destroy = "destroy"

    // Fairplay related methods
    static let fairplayPrepareMessage = "fairplayPrepareMessage"
    static let fairplayPrepareContentId = "fairplayPrepareContentId"
    static let fairplayPrepareCertificate = "fairplayPrepareCertificate"
    static let fairplayPrepareLicense = "fairplayPrepareLicense"
    static let fairplayPrepareLicenseServerUrl = "fairplayPrepareLicenseServerUrl"
    static let fairplayPrepareSyncMessage = "fairplayPrepareSyncMessage"
}
