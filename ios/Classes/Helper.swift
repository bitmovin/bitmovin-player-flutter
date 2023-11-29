import BitmovinPlayer
import Foundation

// swiftlint:disable:next type_body_length
internal enum Helper {
    static func methodCallArguments(_ payload: Any?) -> MethodCallArguments? {
        guard let jsonPayload = payload as? [String: Any?],
              let data = jsonPayload["data"] else {
            return nil
        }

        switch data {
        case let jsonArgument as [String: Any]:
            return .json(jsonArgument)
        case let doubleArgument as Double:
            return .double(doubleArgument)
        case let stringArgument as String:
            return .string(stringArgument)
        default:
            return .empty
        }
    }

    static func toJSONString(_ dictionary: [String: Any]) -> String? {
        guard JSONSerialization.isValidJSONObject(dictionary) else {
            return nil
        }

        guard let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [.prettyPrinted]),
              let jsonString = String(data: jsonData, encoding: .utf8) else {
            return nil
        }

        return jsonString
    }

    /**
     Utility method to instantiate a `PlayerConfig` from a JS object.
     - Parameter json: JS object
     - Returns: The produced `PlayerConfig` object
     */
    static func playerConfig(_ json: [AnyHashable: Any]) -> PlayerConfig {
        let playerConfig = PlayerConfig()

        guard let json = json as? [String: Any] else {
            return playerConfig
        }

        if let licenseKey = json["key"] as? String {
            playerConfig.key = licenseKey
        }

        if let playbackConfig = playbackConfig(json["playbackConfig"]) {
            playerConfig.playbackConfig = playbackConfig
        }

        if let styleConfig = styleConfig(json["styleConfig"]) {
            playerConfig.styleConfig = styleConfig
        }

        if let tweaksConfig = tweaksConfig(json["tweaksConfig"]) {
            playerConfig.tweaksConfig = tweaksConfig
        }

        if let liveConfig = liveConfig(json["liveConfig"]) {
            playerConfig.liveConfig = liveConfig
        }

        if let remoteConfigJson = json["remoteControlConfig"] as? [String: Any],
           let remoteConfig = MessageDecoder.toNative(type: FlutterRemoteControlConfig.self, from: remoteConfigJson) {
            playerConfig.remoteControlConfig = remoteConfig
        }

        return playerConfig
    }

    static func pictureInPictureConfig(_ json: Any?) -> PictureInPictureConfig? {
        guard let json = json as? [String: Any] else {
            return nil
        }

        let pictureInPictureConfig = PictureInPictureConfig()

        if let isEnabled = json["isEnabled"] as? Bool {
            pictureInPictureConfig.isEnabled = isEnabled
        }
        
        if #available(iOS 14.2, *) {
            if let shouldEnterOnBackground = json["shouldEnterOnBackground"] as? Bool {
                pictureInPictureConfig.shouldEnterOnBackground = shouldEnterOnBackground
            }
        }

        return pictureInPictureConfig
    }

    static func liveConfig(_ json: Any?) -> LiveConfig? {
        guard let json = json as? [String: Any] else {
            return nil
        }

        let liveConfig = LiveConfig()

        if let minTimeShiftBufferDepth = json["minTimeShiftBufferDepth"] as? TimeInterval {
            liveConfig.minTimeshiftBufferDepth = minTimeShiftBufferDepth
        }

        return liveConfig
    }

    /**
     Utility method to instantiate a `PlaybackConfig` from a JS object.
     - Parameter json: JS object.
     - Returns: The produced `PlaybackConfig` object.
     */
    static func playbackConfig(_ json: Any?) -> PlaybackConfig? {
        guard let json = json as? [String: Any?] else {
            return nil
        }
        let playbackConfig = PlaybackConfig()
        if let isAutoplayEnabled = json["isAutoplayEnabled"] as? Bool {
            playbackConfig.isAutoplayEnabled = isAutoplayEnabled
        }
        if let isMuted = json["isMuted"] as? Bool {
            playbackConfig.isMuted = isMuted
        }
        if let isTimeShiftEnabled = json["isTimeShiftEnabled"] as? Bool {
            playbackConfig.isTimeShiftEnabled = isTimeShiftEnabled
        }
        if let isBackgroundPlaybackEnabled = json["isBackgroundPlaybackEnabled"] as? Bool {
            playbackConfig.isBackgroundPlaybackEnabled = isBackgroundPlaybackEnabled
        }
        if let isPictureInPictureEnabled = json["isPictureInPictureEnabled"] as? Bool {
            playbackConfig.isPictureInPictureEnabled = isPictureInPictureEnabled
        }
        return playbackConfig
    }

    /**
     Utility method to instantiate a `StyleConfig` from a JS object.
     - Parameter json: JS object.
     - Returns: The produced `StyleConfig` object.
     */
    static func styleConfig(_ json: Any?) -> StyleConfig? { // swiftlint:disable:this cyclomatic_complexity
        guard let json = json as? [String: Any?] else {
            return nil
        }
        let styleConfig = StyleConfig()
        if let isUiEnabled = json["isUiEnabled"] as? Bool {
            styleConfig.isUiEnabled = isUiEnabled
        }
        if let hideFirstFrame = json["isHideFirstFrame"] as? Bool {
#if os(iOS)
            let userInterfaceConfig = BitmovinUserInterfaceConfig()
#else
            let userInterfaceConfig = SystemUserInterfaceConfig()
#endif
            userInterfaceConfig.hideFirstFrame = hideFirstFrame
            styleConfig.userInterfaceConfig = userInterfaceConfig
        }
#if os(iOS)
        if let playerUiCss = json["playerUiCss"] as? String,
           let playerUiCssUrl = URL(string: playerUiCss) {
            styleConfig.playerUiCss = playerUiCssUrl
        }
        if let supplementalPlayerUiCss = json["supplementalPlayerUiCss"] as? String,
           let supplementalPlayerUiCssUrl = URL(string: supplementalPlayerUiCss) {
            styleConfig.supplementalPlayerUiCss = supplementalPlayerUiCssUrl
        }
        if let playerUiJs = json["playerUiJs"] as? String,
           let playerUiJsUrl = URL(string: playerUiJs) {
            styleConfig.playerUiJs = playerUiJsUrl
        }
#endif
        if let scalingMode = json["scalingMode"] as? String {
            switch scalingMode {
            case "Fit":
                styleConfig.scalingMode = .fit
            case "Stretch":
                styleConfig.scalingMode = .stretch
            case "Zoom":
                styleConfig.scalingMode = .zoom
            default:
                break
            }
        }
        return styleConfig
    }

    /**
     Utility method to instantiate a `TweaksConfig` from a JS object.
     - Parameter json: JS object.
     - Returns: The produced `TweaksConfig` object.
     */
    static func tweaksConfig(_ json: Any?) -> TweaksConfig? { // swiftlint:disable:this cyclomatic_complexity
        guard let json = json as? [String: Any?] else {
            return nil
        }

        let tweaksConfig = TweaksConfig()

        if let isNativeHlsParsingEnabled = json["isNativeHlsParsingEnabled"] as? Bool {
            tweaksConfig.isNativeHlsParsingEnabled = isNativeHlsParsingEnabled
        }

        if let isCustomHlsLoadingEnabled = json["isCustomHlsLoadingEnabled"] as? Bool {
            tweaksConfig.isCustomHlsLoadingEnabled = isCustomHlsLoadingEnabled
        }

        if let timeChangedInterval = json["timeChangedInterval"] as? NSNumber {
            tweaksConfig.timeChangedInterval = timeChangedInterval.doubleValue
        }

        if let seekToEndThreshold = json["seekToEndThreshold"] as? NSNumber {
            tweaksConfig.seekToEndThreshold = seekToEndThreshold.doubleValue
        }

        if let playbackStartBehaviour = json["playbackStartBehaviour"] as? String {
            switch playbackStartBehaviour {
            case "relaxed":
                tweaksConfig.playbackStartBehaviour = .relaxed
            case "aggressive":
                tweaksConfig.playbackStartBehaviour = .aggressive
            default:
                break
            }
        }

        if let unstallingBehaviour = json["unstallingBehaviour"] as? String {
            switch unstallingBehaviour {
            case "relaxed":
                tweaksConfig.unstallingBehaviour = .relaxed
            case "aggressive":
                tweaksConfig.unstallingBehaviour = .aggressive
            default:
                break
            }
        }

        return tweaksConfig
    }

    static func source(_ json: [String: Any]) -> FlutterSource? {
        guard let sourceConfigJson = json["sourceConfig"] as? [String: Any],
              let flutterSourceConfig = sourceConfig(sourceConfigJson) else {
            return nil
        }

        var remoteControl: SourceRemoteControlConfig?
        if let remoteControlJson = json["remoteControl"] as? [String: Any] {
            remoteControl = sourceRemoteControlConfig(remoteControlJson)
        }

        return FlutterSource(
            sourceConfig: flutterSourceConfig,
            remoteControl: remoteControl
        )
    }

    static func sourceRemoteControlConfig(_ json: [String: Any]) -> SourceRemoteControlConfig {
        var castSourceConfig: FlutterSourceConfig?
        if let castSourceConfigJson = json["castSourceConfig"] as? [String: Any] {
            castSourceConfig = sourceConfig(castSourceConfigJson)
        }

        return SourceRemoteControlConfig(castSourceConfig: castSourceConfig)
    }

    /**
     Utility method to instantiate a `SourceConfig` from a JS object.
     - Parameter json: JS object
     - Returns: The produced `SourceConfig` object
     */
    static func sourceConfig(_ json: [String: Any]) -> FlutterSourceConfig? {
        guard let sourceUrlString = json["url"] as? String,
              let sourceUrl = URL(string: sourceUrlString) else {
            return nil
        }

        let sourceConfig = SourceConfig(
            url: sourceUrl,
            type: sourceType(json["type"])
        )

        var fairplayConfigMetadata: FairplayConfig.Metadata?

        if let drmConfig = json["drmConfig"] as? [String: Any],
           let fairplayConfigJson = drmConfig["fairplay"] as? [String: Any] {
            sourceConfig.drmConfig = fairplayConfig(fairplayConfigJson)
            fairplayConfigMetadata = Self.fairplayConfigMetadata(fairplayConfigJson)
        }

        if let title = json["title"] as? String {
            sourceConfig.title = title
        }

        if let description = json["description"] as? String {
            sourceConfig.sourceDescription = description
        }

        if let posterSource = json["posterSource"] as? String {
            sourceConfig.posterSource = URL(string: posterSource)
        }

        if let isPosterPersistent = json["isPosterPersistent"] as? Bool {
            sourceConfig.isPosterPersistent = isPosterPersistent
        }

        if let subtitleTracks = json["subtitleTracks"] as? [[String: Any]] {
            subtitleTracks.forEach {
                if let subtitleTrack = MessageDecoder.toNative(type: FlutterSubtitleTrack.self, from: $0) {
                    sourceConfig.add(subtitleTrack: subtitleTrack)
                }
            }
        }

        if let options = json["options"] as? [String: Any] {
            sourceConfig.options = sourceOptions(options)
        }

        if let thumbnailTrack = json["thumbnailTrack"] as? String {
            sourceConfig.thumbnailTrack = self.thumbnailTrack(thumbnailTrack)
        }

        let analyticsSourceMetadata = MessageDecoder.toNative(
            type: FlutterSourceMetadata.self,
            from: json["analyticsSourceMetadata"]
        )

        return FlutterSourceConfig(
            config: sourceConfig,
            drmMetadata: fairplayConfigMetadata,
            analyticsSourceMetadata: analyticsSourceMetadata
        )
    }

    static func sourceOptions(_ json: [String: Any]) -> SourceOptions {
        let sourceOptions = SourceOptions()

        if let startOffset = json["startOffset"] as? Double {
            sourceOptions.startOffset = startOffset
        }

        sourceOptions.startOffsetTimelineReference = timelineReferencePoint(json["startOffsetTimelineReference"])

        return sourceOptions
    }

    static func timelineReferencePoint(_ json: Any?) -> TimelineReferencePoint {
        guard let json = json as? String else {
            return .auto
        }

        switch json {
        case "Start":
            return .start
        case "End":
            return .end
        default:
            return .auto
        }
    }

    /**
     Utility method to get a `SourceType` from a JS object.
     - Parameter json: JS object
     - Returns: The associated `SourceType` value
     */
    static func sourceType(_ json: Any?) -> SourceType {
        guard let json = json as? String else {
            return .none
        }
        switch json {
        case "none":
            return .none
        case "hls":
            return .hls
        case "dash":
            return .dash
        case "progressive":
            return .progressive
        default:
            return .none
        }
    }

    /**
     Utility method to get a `TimeMode` from a JS object.
     - Parameter json: JS object
     - Returns: The associated `TimeMode` value
     */
    static func timeMode(_ json: Any?) -> TimeMode {
        guard let json = json as? String else {
            return .absoluteTime
        }
        switch json {
        case "absolute":
            return .absoluteTime
        case "relative":
            return .relativeTime
        default:
            return .absoluteTime
        }
    }

    /**
     Utility method to get a `FairplayConfig` from a JS object.
     - Parameter json: JS object
     - Returns: The generated `FairplayConfig` object
     */
    static func fairplayConfig(_ json: [String: Any]) -> FairplayConfig? {
        guard let certificateUrlString = json["certificateUrl"] as? String,
              let certificateUrl = URL(string: certificateUrlString) else {
            return nil
        }

        var licenseUrl: URL?
        if let licenseUrlString = json["licenseUrl"] as? String {
            licenseUrl = URL(string: licenseUrlString)
        }

        let fairplayConfig = FairplayConfig(license: licenseUrl, certificateURL: certificateUrl)

        if let licenseRequestHeaders = json["licenseRequestHeaders"] as? [String: String] {
            fairplayConfig.licenseRequestHeaders = licenseRequestHeaders
        }

        if let certificateRequestHeaders = json["certificateRequestHeaders"] as? [String: String] {
            fairplayConfig.certificateRequestHeaders = certificateRequestHeaders
        }

        return fairplayConfig
    }

    /// Returns a `FairplayConfig.Metadata` object that tells which callbacks from `FairplayConfig` are implemented
    /// on the Dart side.
    ///
    /// - Parameter json: JSON representation of `FairplayConfig`.
    /// - Returns: The created `FairplayConfig.Metadata` object.
    private static func fairplayConfigMetadata(_ fairplayConfig: [String: Any]) -> FairplayConfig.Metadata {
        FairplayConfig.Metadata(
            hasPrepareMessage: fairplayConfig["prepareMessage"] as? Bool ?? false,
            hasPrepareContentId: fairplayConfig["prepareContentId"] as? Bool ?? false,
            hasPrepareCertificate: fairplayConfig["prepareCertificate"] as? Bool ?? false,
            hasPrepareLicense: fairplayConfig["prepareLicense"] as? Bool ?? false,
            hasPrepareLicenseServerUrl: fairplayConfig["prepareLicenseServerUrl"] as? Bool ?? false,
            hasPrepareSyncMessage: fairplayConfig["prepareSyncMessage"] as? Bool ?? false
        )
    }

    /**
     Utility method to get a `ThumbnailTrack` instance from a JS object.
     - Parameter url: String.
     - Returns: The generated `ThumbnailTrack`.
     */
    static func thumbnailTrack(_ url: String?) -> ThumbnailTrack? {
        guard let urlString = url, let url = URL(string: urlString) else {
            return nil
        }
        return ThumbnailTrack(
            url: url,
            label: "Thumbnails",
            identifier: UUID().uuidString,
            isDefaultTrack: false
        )
    }

    /**
     Utility method to get a json dictionary value from a `AudioTrack` object.
     - Parameter audioTrack: The track to convert to json format.
     - Returns: The generated json dictionary.
     */
    static func audioTrackJson(_ audioTrack: AudioTrack) -> [AnyHashable: Any] {
        [
            "url": audioTrack.url?.absoluteString ?? "",
            "label": audioTrack.label,
            "isDefault": audioTrack.isDefaultTrack,
            "identifier": audioTrack.identifier,
            "language": audioTrack.language ?? ""
        ]
    }

    /**
     Utility method to compute a JS value from a `VideoQuality` object.
     - Parameter videoQuality `VideoQuality` object to be converted.
     - Returns: The produced JS object.
     */
    static func toJson(videoQuality: VideoQuality) -> [String: Any] {
        var result: [String: Any] = [
            "id": videoQuality.identifier,
            "label": videoQuality.label,
            "height": videoQuality.height,
            "width": videoQuality.width,
            "bitrate": videoQuality.bitrate
        ]

        if let codec = videoQuality.codec {
            result["codec"] = codec
        }

        return result
    }
}
