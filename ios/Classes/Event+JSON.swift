//
//  Event_JSON.swift
//  bitmovin_sdk
//
//  Created by Vijae Manlapaz on 4/26/23.
//

import BitmovinPlayer

extension Source {
    func toJSON() -> [String: Any] {
			func _loadingStateToValue(_ loadingState: LoadingState) -> String {
				switch loadingState {
					case .loaded:
						return "loaded"
					case .loading:
						return "loading"
					case .unloaded:
						return "unloaded"
					@unknown default:
						return "unknown"
				}
			}
        var json: [String: Any] = [
            "duration": duration,
            "isActive": isActive,
						"loadingState": _loadingStateToValue(loadingState),
            "isAttachedToPlayer": isAttachedToPlayer
        ]
        if let metadata = metadata {
            json["metadata"] = metadata
        }
        return json
    }
}

extension SeekEvent {
    func toJSON() -> [String: Any] {
        [
            "event": name,
            "timestamp": Int(timestamp),
            "from": [
                "time": from.time,
                "source": from.source.toJSON()
            ],
            "to": [
                "time": to.time,
                "source": to.source.toJSON()
            ]
        ]
    }
}

extension TimeChangedEvent {
    func toJSON() -> [String: Any] {
        ["event": name, "timestamp": Int(timestamp), "currentTime": currentTime]
    }
}

extension Event {
    func toJSON() -> [String: Any] {
        ["event": name, "timestamp": Int(timestamp)]
    }
}

extension NSError {
    func toJSON() -> [String: Any] {
        [
            "code": code,
            "domain": domain,
            "description": description,
            "localizedDescription": localizedDescription
        ]
    }
}

extension DeficiencyData {
    func toJSON() -> [String: Any] {
        var json: [String: Any] = ["code": code, "message": message]
        if let underlyingError = underlyingError {
            json["underlyingError"] = underlyingError.toJSON()
        }
        return json
    }
}

protocol ErrorEventType: Event {
    associatedtype Code
    var code: Code { get }
    var data: DeficiencyData? { get }
    var message: String { get }
}

extension ErrorEventType {
    func toJSON() -> [String: Any] {
        var json: [String: Any] = [
            "event": name,
            "timestamp": Int(timestamp),
            "code": code,
            "message": message
        ]
        if let data = data {
            json["data"] = data.toJSON()
        }
        return json
    }
}

extension PlayerErrorEvent: ErrorEventType {
    typealias Code = PlayerError.Code
}

extension PlayerWarningEvent: ErrorEventType {
    typealias Code = PlayerWarning.Code
}

extension SourceErrorEvent: ErrorEventType {
    typealias Code = SourceError.Code
}

extension SourceWarningEvent: ErrorEventType {
    typealias Code = SourceWarning.Code
}

protocol SourceEventType: Event {
    var source: Source { get }
}

extension SourceEventType {
    func toJSON() -> [String: Any] {
        ["event": name, "timestamp": Int(timestamp), "source": source.toJSON()]
    }
}

extension SourceLoadEvent: SourceEventType {}
extension SourceLoadedEvent: SourceEventType {}
extension SourceUnloadedEvent: SourceEventType {}

protocol TimedEventType: Event {
    var time: TimeInterval { get }
}

extension TimedEventType {
    func toJSON() -> [String: Any] {
        ["event": name, "timestamp": Int(timestamp), "time": time]
    }
}

extension PlayEvent: TimedEventType {}
extension PausedEvent: TimedEventType {}
extension PlayingEvent: TimedEventType {}

extension AudioAddedEvent {
    func toJSON() -> [String: Any] {
        [
            "event": name,
						"timestamp": Int(timestamp),
            "audioTrack": Helper.audioTrackJson(audioTrack),
            "time": time
        ]
    }
}

extension AudioRemovedEvent {
    func toJSON() -> [String: Any] {
        [
            "event": name,
            "timestamp": Int(timestamp),
            "audioTrack": Helper.audioTrackJson(audioTrack),
            "time": time
        ]
    }
}

extension AudioChangedEvent {
    func toJSON() -> [String: Any] {
        [
            "event": name,
            "timestamp": Int(timestamp),
            "oldAudioTrack": Helper.audioTrackJson(audioTrackOld),
            "newAudioTrack": Helper.audioTrackJson(audioTrackNew)
        ]
    }
}


extension SubtitleAddedEvent {
    func toJSON() -> [String: Any] {
        [
            "event": name,
            "timestamp": Int(timestamp),
            "subtitleTrack": Helper.subtitleTrackJson(subtitleTrack)
        ]
    }
}

extension SubtitleRemovedEvent {
    func toJSON() -> [String: Any] {
        [
            "event": name,
            "timestamp": Int(timestamp),
            "subtitleTrack": Helper.subtitleTrackJson(subtitleTrack)
        ]
    }
}

extension SubtitleChangedEvent {
    func toJSON() -> [String: Any] {
        [
            "event": name,
            "timestamp": Int(timestamp),
            "oldSubtitleTrack": Helper.subtitleTrackJson(subtitleTrackOld),
            "newSubtitleTrack": Helper.subtitleTrackJson(subtitleTrackNew)
        ]
    }
}

extension AdBreakFinishedEvent {
    func toJSON() -> [String: Any] {
        [
            "event": name,
            "timestamp": Int(timestamp),
            "adBreak": Helper.toJson(adBreak: adBreak)
        ]
    }
}

extension AdBreakStartedEvent {
    func toJSON() -> [String: Any] {
        [
            "event": name,
            "timestamp": Int(timestamp),
            "adBreak": Helper.toJson(adBreak: adBreak)
        ]
    }
}

extension AdClickedEvent {
    func toJSON() -> [String: Any] {
        [
            "event": name,
            "timestamp": Int(timestamp),
            "clickThroughUrl": clickThroughUrl
        ]
    }
}

extension AdErrorEvent {
    func toJSON() -> [String: Any] {
        [
            "event": name,
            "timestamp": Int(timestamp),
            "adConfig": Helper.toJson(adConfig: adConfig),
            "adItem": Helper.toJson(adItem: adItem),
            "code": code,
            "message": message
        ]
    }
}

extension AdFinishedEvent {
    func toJSON() -> [String: Any] {
        [
            "event": name,
            "timestamp": Int(timestamp),
            "ad": Helper.toJson(ad: ad)
        ]
    }
}

extension AdManifestLoadEvent {
    func toJSON() -> [String: Any] {
        [
            "event": name,
            "timestamp": Int(timestamp),
            "adBreak": Helper.toJson(adBreak: adBreak),
            "adConfig": Helper.toJson(adConfig: adConfig)
        ]
    }
}

extension AdManifestLoadedEvent {
    func toJSON() -> [String: Any] {
        [
            "event": name,
            "timestamp": Int(timestamp),
            "adBreak": Helper.toJson(adBreak: adBreak),
            "adConfig": Helper.toJson(adConfig: adConfig),
            "downloadTime": downloadTime
        ]
    }
}

extension AdQuartileEvent {
    func toJSON() -> [String: Any] {
        [
            "event": name,
            "timestamp": Int(timestamp),
            "quartile": Helper.toJson(adQuartile: adQuartile)
        ]
    }
}

extension AdScheduledEvent {
    func toJSON() -> [String: Any] {
        [
            "event": name,
            "timestamp": Int(timestamp),
            "numberOfAds": numberOfAds
        ]
    }
}

extension AdSkippedEvent {
    func toJSON() -> [String: Any] {
        [
            "event": name,
            "timestamp": Int(timestamp),
            "ad": Helper.toJson(ad: ad)
        ]
    }
}

extension AdStartedEvent {
    func toJSON() -> [String: Any] {
        [
            "event": name,
            "timestamp": Int(timestamp),
            "ad": Helper.toJson(ad: ad),
            "clickThroughUrl": clickThroughUrl?.absoluteString,
            "clientType": Helper.toJson(adSourceType: clientType),
            "duration": duration,
            "indexInQueue": indexInQueue,
            "position": position,
            "skipOffset": skipOffset,
            "timeOffset": timeOffset
        ]
    }
}

extension VideoDownloadQualityChangedEvent {
    func toJSON() -> [String: Any] {
        [
            "newVideoQuality": Helper.toJson(videoQuality: videoQualityNew),
            "oldVideoQuality": Helper.toJson(videoQuality: videoQualityOld),
            "event": name,
            "timestamp": Int(timestamp)
        ]
    }
}
