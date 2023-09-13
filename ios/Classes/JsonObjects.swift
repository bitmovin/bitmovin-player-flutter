// swiftlint:disable:this file_name
import BitmovinPlayer
import Foundation

internal protocol FlutterToNativeConvertible: Codable {
    associatedtype NativeObject
    func toNative() -> NativeObject
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

internal struct FlutterSubtitleTrack: FlutterToNativeConvertible {
    let url: String?
    let format: String?
    let label: String
    let id: String
    let isDefault: Bool
    let language: String?
    let isForced: Bool

    // TODO: we also need a fromNative to bridge platform inconsistencies
    // In that course, remove the according parts from Helper.swift

    func toNative() -> SubtitleTrack {
        let subtitleTrackUrl: URL?
        if let url {
            subtitleTrackUrl = URL(string: url)
        } else {
            subtitleTrackUrl = nil
        }

        let subtitleTrackFormat: SubtitleFormat
        switch format?.lowercased() {
        case "webvtt":
            subtitleTrackFormat = .webVtt
        case "ttml":
            subtitleTrackFormat = .ttml
        case "cea":
            subtitleTrackFormat = .cea
        default:
            subtitleTrackFormat = .webVtt
        }

        return SubtitleTrack(
            url: subtitleTrackUrl,
            format: subtitleTrackFormat,
            label: label,
            identifier: id,
            isDefaultTrack: isDefault,
            language: language,
            forced: isForced
        )
    }
}
