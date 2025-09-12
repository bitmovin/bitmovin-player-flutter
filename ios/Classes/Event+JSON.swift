import BitmovinPlayer

extension LoadingState {
    func toValue() -> String {
        switch self {
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
}

extension Source {
    func toJSON() -> [String: Any] {
        var json: [String: Any] = [
            "duration": duration.jsonValue,
            "isActive": isActive,
            "loadingState": loadingState.toValue(),
            "isAttachedToPlayer": isAttachedToPlayer,
            "sourceConfig": sourceConfig.toJSON()
        ]
        if let metadata {
            json["metadata"] = metadata
        }
        return json
    }
}

extension SourceConfig {
    func toJSON() -> [String: Any] {
        var json: [String: Any] = [:]
        json["title"] = self.title
        json["url"] = self.url.absoluteString
        json["metadata"] = self.metadata
        json["isPosterPersistent"] = self.isPosterPersistent
        json["options"] = self.options.toJSON()
        json["labelingConfig"] = self.labelingConfig.toJSON()
        json["type"] = self.type.toValue()
        json["subtitleTracks"] = self.tracks.compactMap { track -> [String: Any]? in
            guard let subtitleTrack = track as? SubtitleTrack else {
                return nil
            }
            return subtitleTrack.toJson()
        }

        if let target = self.sourceDescription {
            json["sourceDescription"] = target
        } else {
            json["sourceDescription"] = nil
        }

        if let target = self.posterSource {
            json["posterSource"] = target.absoluteString
        } else {
            json["posterSource"] = nil
        }

        if let target = self.drmConfig {
            json["drmConfig"] = target.toJSON()
        } else {
            json["drmConfig"] = nil
        }

        return json
    }
}

extension SourceType {
    func toValue() -> String {
        switch self {
        case .none:
            return "none"
        case .hls:
            return "hls"
        case .dash:
            return "dash"
        case .progressive:
            return "progressive"
        case .movpkg:
            return "movpkg"
        @unknown default:
            return "unknown"
        }
    }
}

extension DrmConfig {
    func toJSON() -> [String: Any] {
        var json: [String: Any] = [:]
        if let licenseUrl {
            json["licenseUrl"] = licenseUrl.absoluteString
        }
        json["uuid"] = self.uuid.uuidString
        return json
    }
}

extension TimelineReferencePoint {
    func toValue() -> String? {
        switch self {
        case .auto:
            return "auto"
        case .end:
            return "end"
        case .start:
            return "start"
        @unknown default:
            return "auto"
        }
    }
}

extension SourceOptions {
    func toJSON() -> [String: Any] {
        var json: [String: Any] = [:]
        json["startOffset"] = self.startOffset.isNaN ? nil : self.startOffset
        if startOffsetTimelineReference != .auto {
            json["startOffsetTimelineReference"] = self.startOffsetTimelineReference.toValue()
        }
        return json
    }
}

extension LabelingConfig {
    func toJSON() -> [String: Any] {
        var json: [String: Any] = [:]
        json["audioLabel"] = self.audioLabel
        json["subtitleLabel"] = self.subtitleLabel
        return json
    }
}

extension TrackType {
    func toValue() -> String {
        switch self {
        case .audio:
            return "audio"
        case .thumbnail:
            return "thumbnail"
        case .text:
            return "text"
        case .none:
            return "none"
        @unknown default:
            return "unknown"
        }
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
            ] as [String: Any],
            "to": [
                "time": to.time,
                "source": to.source.toJSON()
            ] as [String: Any]
        ]
    }
}

extension TimeShiftEvent {
    func toJSON() -> [String: Any] {
        [
            "event": name,
            "timestamp": Int(timestamp),
            "position": position,
            "target": target
        ]
    }
}

extension TimeChangedEvent {
    func toJSON() -> [String: Any] {
        ["event": name, "timestamp": Int(timestamp), "currentTime": currentTime]
    }
}

extension Event {
    func toJsonFallback() -> [String: Any] {
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
        [
            "code": code,
            "message": message,
            "underlyingError": underlyingError.toJSON()
        ]
    }
}

extension PlayerErrorEvent {
    func toJSON() -> [String: Any] {
        var json: [String: Any] = [
            "event": name,
            "timestamp": Int(timestamp),
            "code": code.rawValue,
            "message": message
        ]
        if let data {
            json["data"] = data.toJSON()
        }
        return json
    }
}

extension PlayerWarningEvent {
    func toJSON() -> [String: Any] {
        var json: [String: Any] = [
            "event": name,
            "timestamp": Int(timestamp),
            "code": code.rawValue,
            "message": message
        ]
        if let data {
            json["data"] = data.toJSON()
        }
        return json
    }
}

extension SourceErrorEvent {
    func toJSON() -> [String: Any] {
        var json: [String: Any] = [
            "event": name,
            "timestamp": Int(timestamp),
            "code": code.rawValue,
            "message": message
        ]
        if let data {
            json["data"] = data.toJSON()
        }
        return json
    }
}

extension SourceWarningEvent {
    func toJSON() -> [String: Any] {
        var json: [String: Any] = [
            "event": name,
            "timestamp": Int(timestamp),
            "code": code.rawValue,
            "message": message
        ]
        if let data {
            json["data"] = data.toJSON()
        }
        return json
    }
}

internal protocol SourceEventType: Event {
    var source: Source { get }
}

extension SourceEventType {
    func toJSON() -> [String: Any] {
        ["name": name, "timestamp": Int(timestamp), "source": source.toJSON()]
    }
}

extension SourceAddedEvent {
    func toJSON() -> [String: Any] {
        [
            "name": name,
            "timestamp": Int(timestamp),
            "source": source.toJSON(),
            "index": index
        ]
    }
}

extension SourceRemovedEvent {
    func toJSON() -> [String: Any] {
        [
            "name": name,
            "timestamp": Int(timestamp),
            "source": source.toJSON(),
            "index": index
        ]
    }
}

extension SourceLoadEvent: SourceEventType {}
extension SourceLoadedEvent: SourceEventType {}
extension SourceUnloadEvent: SourceEventType {}
extension SourceUnloadedEvent: SourceEventType {}

internal protocol TimedEventType: Event {
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
        var result: [String: Any] = [
            "event": name,
            "timestamp": Int(timestamp),
            "newAudioTrack": Helper.audioTrackJson(audioTrackNew)
        ]

        if let audioTrackOld {
            result["oldAudioTrack"] = Helper.audioTrackJson(audioTrackOld)
        }

        return result
    }
}

extension SubtitleAddedEvent {
    func toJSON() -> [String: Any?] {
        [
            "event": name,
            "timestamp": Int(timestamp),
            "subtitleTrack": subtitleTrack.toJson()
        ]
    }
}

extension SubtitleRemovedEvent {
    func toJSON() -> [String: Any?] {
        [
            "event": name,
            "timestamp": Int(timestamp),
            "subtitleTrack": subtitleTrack.toJson()
        ]
    }
}

extension SubtitleChangedEvent {
    func toJSON() -> [String: Any] {
        var result: [String: Any] = [
            "event": name,
            "timestamp": Int(timestamp)
        ]

        if let json = subtitleTrackOld?.toJson() {
            result["oldSubtitleTrack"] = json
        }

        if let json = subtitleTrackNew?.toJson() {
            result["newSubtitleTrack"] = json
        }

        return result
    }
}

extension VideoDownloadQualityChangedEvent {
    func toJSON() -> [String: Any] {
        var result: [String: Any] = [
            "event": name,
            "timestamp": Int(timestamp)
        ]

        if let videoQualityNew {
            result["newVideoQuality"] = Helper.toJson(videoQuality: videoQualityNew)
        }

        if let videoQualityOld {
            result["oldVideoQuality"] = Helper.toJson(videoQuality: videoQualityOld)
        }

        return result
    }
}

extension CastStartedEvent {
    func toJSON() -> [String: Any] {
        [
            "event": name,
            "timestamp": Int(timestamp),
            "deviceName": deviceName
        ]
    }
}

extension CastWaitingForDeviceEvent {
    func toJSON() -> [String: Any] {
        [
            "event": name,
            "timestamp": Int(timestamp),
            "castPayload": [
                "currentTime": castPayload.currentTime,
                "deviceName": castPayload.deviceName
            ] as [String: Any]
        ]
    }
}

extension AirPlayChangedEvent {
    func toJSON() -> [String: Any] {
        [
            "event": name,
            "timestamp": Int(timestamp),
            "isAirPlayActive": isAirPlayActive,
            "time": time
        ]
    }
}

extension Double {
    var jsonValue: Any {
        switch self {
        case .infinity:
            return "Infinity"
        case .nan:
            return "NaN"
        default:
            return self
        }
    }
}
