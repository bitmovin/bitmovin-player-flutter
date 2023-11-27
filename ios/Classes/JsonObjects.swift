// swiftlint:disable:this file_name
import BitmovinPlayer
import Foundation

internal protocol FlutterToNativeConvertible: Codable {
    associatedtype NativeObject
    func toNative() -> NativeObject
}

internal protocol NativeToFlutterConvertible {
    associatedtype FlutterObject where FlutterObject: Codable
    func toFlutter() -> FlutterObject
    func toJson() -> [String: Any]?
    func toJsonString() -> String?
}

extension NativeToFlutterConvertible {
    func toJson() -> [String: Any]? {
        guard let jsonData = try? JSONEncoder().encode(toFlutter()) else {
            return nil
        }

        return try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
    }

    func toJsonString() -> String? {
        guard let jsonData = try? JSONEncoder().encode(toFlutter()) else {
            return nil
        }

        return String(data: jsonData, encoding: .utf8)
    }
}

internal struct FlutterAnalyticsConfig: FlutterToNativeConvertible {
    let licenseKey: String
    let retryPolicy: String
    let randomizeUserId: Bool
    let adTrackingDisabled: Bool
    let backendUrl: String
    let defaultMetadata: FlutterDefaultMetadata

    func toNative() -> AnalyticsConfig {
        let retryPolicy: RetryPolicy
        switch self.retryPolicy {
        case "ShortTerm", "NoRetry":
            retryPolicy = RetryPolicy.noRetry
        case "LongTerm":
            retryPolicy = RetryPolicy.longTerm
        default:
            retryPolicy = RetryPolicy.noRetry
        }

        return AnalyticsConfig(
            licenseKey: licenseKey,
            retryPolicy: retryPolicy,
            randomizeUserId: randomizeUserId,
            adTrackingDisabled: adTrackingDisabled,
            backendUrl: backendUrl
        )
    }
}

internal struct FlutterCustomData: FlutterToNativeConvertible {
    let customData1: String?
    let customData2: String?
    let customData3: String?
    let customData4: String?
    let customData5: String?
    let customData6: String?
    let customData7: String?
    let customData8: String?
    let customData9: String?
    let customData10: String?
    let customData11: String?
    let customData12: String?
    let customData13: String?
    let customData14: String?
    let customData15: String?
    let customData16: String?
    let customData17: String?
    let customData18: String?
    let customData19: String?
    let customData20: String?
    let customData21: String?
    let customData22: String?
    let customData23: String?
    let customData24: String?
    let customData25: String?
    let customData26: String?
    let customData27: String?
    let customData28: String?
    let customData29: String?
    let customData30: String?
    let experimentName: String?

    func toNative() -> CustomData {
        CustomData(
            customData1: customData1,
            customData2: customData2,
            customData3: customData3,
            customData4: customData4,
            customData5: customData5,
            customData6: customData6,
            customData7: customData7,
            customData8: customData8,
            customData9: customData9,
            customData10: customData10,
            customData11: customData11,
            customData12: customData12,
            customData13: customData13,
            customData14: customData14,
            customData15: customData15,
            customData16: customData16,
            customData17: customData17,
            customData18: customData18,
            customData19: customData19,
            customData20: customData20,
            customData21: customData21,
            customData22: customData22,
            customData23: customData23,
            customData24: customData24,
            customData25: customData25,
            customData26: customData26,
            customData27: customData27,
            customData28: customData28,
            customData29: customData29,
            customData30: customData30,
            experimentName: experimentName
        )
    }
}

internal struct FlutterDefaultMetadata: FlutterToNativeConvertible {
    let cdnProvider: String?
    let customUserId: String?
    let customData: FlutterCustomData

    func toNative() -> DefaultMetadata {
        DefaultMetadata(
            cdnProvider: cdnProvider,
            customUserId: customUserId,
            customData: customData.toNative()
        )
    }
}

internal struct FlutterSourceMetadata: FlutterToNativeConvertible {
    let videoId: String?
    let title: String?
    let path: String?
    let isLive: Bool?
    let cdnProvider: String?
    let customData: FlutterCustomData

    func toNative() -> SourceMetadata {
        SourceMetadata(
            videoId: videoId,
            title: title,
            path: path,
            isLive: isLive,
            cdnProvider: cdnProvider,
            customData: customData.toNative()
        )
    }
}

internal struct FlutterCueEnterEvent: Codable {
    let start: TimeInterval
    let end: TimeInterval
    let text: String?
}

extension CueEnterEvent: NativeToFlutterConvertible {
    func toFlutter() -> FlutterCueEnterEvent {
        FlutterCueEnterEvent(start: startTime, end: endTime, text: text)
    }
}

internal struct FlutterCueExitEvent: Codable {
    let start: TimeInterval
    let end: TimeInterval
    let text: String?
}

extension CueExitEvent: NativeToFlutterConvertible {
    func toFlutter() -> FlutterCueExitEvent {
        FlutterCueExitEvent(start: startTime, end: endTime, text: text)
    }
}

internal struct FlutterSubtitleTrack: FlutterToNativeConvertible {
    let url: String?
    let format: String?
    let label: String
    let id: String
    let isDefault: Bool
    let language: String?
    let isForced: Bool

    func toNative() -> SubtitleTrack {
        let subtitleTrackUrl: URL?
        if let url {
            subtitleTrackUrl = URL(string: url)
        } else {
            subtitleTrackUrl = nil
        }

        return SubtitleTrack(
            url: subtitleTrackUrl,
            format: format?.subtitleFormat ?? .webVtt,
            label: label,
            identifier: id,
            isDefaultTrack: isDefault,
            language: language,
            forced: isForced
        )
    }
}

extension SubtitleTrack: NativeToFlutterConvertible {
    func toFlutter() -> FlutterSubtitleTrack {
        FlutterSubtitleTrack(
            url: url?.absoluteString,
            format: format.stringValue,
            label: label,
            id: identifier,
            isDefault: isDefaultTrack,
            language: language,
            isForced: isForced
        )
    }
}

private extension String {
    var subtitleFormat: SubtitleFormat {
        switch self.lowercased() {
        case JsonValues.SubtitleFormat.vtt:
            return .webVtt
        case JsonValues.SubtitleFormat.ttml:
            return .ttml
        case let value where value.hasPrefix(JsonValues.SubtitleFormat.cea):
            return .cea
        default:
            return .webVtt
        }
    }
}

private extension SubtitleFormat {
    var stringValue: String {
        switch self {
        case .cea:
            return JsonValues.SubtitleFormat.cea
        case .ttml:
            return JsonValues.SubtitleFormat.ttml
        case .webVtt:
            return JsonValues.SubtitleFormat.vtt
        default:
            return JsonValues.SubtitleFormat.vtt
        }
    }
}

// Values used to handle iOS Player SDK objects that are not directly convertible
// to meaningful JSON compatible values, like for instance Obj-C enums.
private enum JsonValues {
    enum SubtitleFormat {
        static let cea = "application/cea"
        static let ttml = "application/ttml+xml"
        static let vtt = "text/vtt"
    }
}

internal struct FlutterRemoteControlConfig: FlutterToNativeConvertible {
    let receiverStylesheetUrl: String?
    let customReceiverConfig: [String: String]
    let isAirPlayEnabled: Bool
    let isCastEnabled: Bool
    let sendManifestRequestsWithCredentials: Bool
    let sendSegmentRequestsWithCredentials: Bool
    let sendDrmLicenseRequestsWithCredentials: Bool

    func toNative() -> RemoteControlConfig {
        let result = RemoteControlConfig()
        if let receiverStylesheetUrl {
            result.receiverStylesheetUrl = URL(string: receiverStylesheetUrl)
        }

        result.customReceiverConfig = customReceiverConfig
        result.isAirPlayEnabled = isAirPlayEnabled
        result.isCastEnabled = isCastEnabled
        result.sendManifestRequestsWithCredentials = sendManifestRequestsWithCredentials
        result.sendSegmentRequestsWithCredentials = sendSegmentRequestsWithCredentials
        result.sendDrmLicenseRequestsWithCredentials = sendDrmLicenseRequestsWithCredentials

        return result
    }
}

extension RemoteControlConfig: NativeToFlutterConvertible {
    func toFlutter() -> FlutterRemoteControlConfig {
        FlutterRemoteControlConfig(
            receiverStylesheetUrl: receiverStylesheetUrl?.absoluteString,
            customReceiverConfig: customReceiverConfig,
            isAirPlayEnabled: isAirPlayEnabled,
            isCastEnabled: isCastEnabled,
            sendManifestRequestsWithCredentials: sendManifestRequestsWithCredentials,
            sendSegmentRequestsWithCredentials: sendSegmentRequestsWithCredentials,
            sendDrmLicenseRequestsWithCredentials: sendDrmLicenseRequestsWithCredentials
        )
    }
}

internal struct FlutterBitmovinCastManagerOptions: FlutterToNativeConvertible {
    let applicationId: String?
    let messageNamespace: String?

    func toNative() -> BitmovinCastManagerOptions {
        let result = BitmovinCastManagerOptions()
        result.applicationId = applicationId
        result.messageNamespace = messageNamespace

        return result
    }
}

internal struct BitmovinCastManagerSendMessageArgs: Codable {
    let message: String
    let messageNamespace: String?
}

internal struct FlutterSourceConfig {
    let config: SourceConfig
    let drmMetadata: FairplayConfig.Metadata?
    let analyticsSourceMetadata: SourceMetadata?
}

internal struct FlutterSource {
    let sourceConfig: FlutterSourceConfig
    let remoteControl: SourceRemoteControlConfig?
}

internal struct SourceRemoteControlConfig {
    let castSourceConfig: FlutterSourceConfig?
}
