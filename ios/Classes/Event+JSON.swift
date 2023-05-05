//
//  Event_JSON.swift
//  bitmovin_sdk
//
//  Created by Vijae Manlapaz on 4/26/23.
//

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
			"duration": duration,
			"isActive": isActive,
			"loadingState": loadingState.toValue(),
			"isAttachedToPlayer": isAttachedToPlayer,
			"sourceConfig": sourceConfig.toJSON(),
		]
		if let metadata = metadata {
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
		json["tracks"] = self.tracks.map({ track in
			return track.toJSON()
		})
		
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

		if let target = self.thumbnailTrack {
			json["thumbnailTrack"] = target.toJSON()
		} else {
			json["thumbnailTrack"] = nil
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
		json["licenseUrl"] = self.licenseUrl
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
		json["startOffsetTimelineReference"] = self.startOffsetTimelineReference.toValue()
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

extension Track {
	func toJSON() -> [String: Any] {
		var json: [String: Any] = [:]
		json["url"] = self.url?.absoluteString
		json["identifier"] = self.identifier
		json["isDefaultTrack"] = self.isDefaultTrack
		json["label"] = self.label
		json["type"] = self.type.toValue()
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

extension PlayerErrorEvent {
	func toJSON() -> [String: Any] {
			var json: [String: Any] = [
					"event": name,
					"timestamp": Int(timestamp),
					"code": code.rawValue,
					"message": message
			]
			if let data = data {
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
			if let data = data {
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
			if let data = data {
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
			if let data = data {
					json["data"] = data.toJSON()
			}
			return json
	}
}

protocol SourceEventType: Event {
    var source: Source { get }
}

extension SourceEventType {
    func toJSON() -> [String: Any] {
        ["event": name, "timestamp": Int(timestamp), "source": source.toJSON()]
    }
}

extension SourceAddedEvent: SourceEventType {}
extension SourceRemovedEvent: SourceEventType {}
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
