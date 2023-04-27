//
//  PlayerMethod.swift
//  bitmovin_sdk
//
//  Created by Vijae Manlapaz on 4/26/23.
//

import Foundation
import Flutter
import BitmovinPlayer

class PlayerMethod: NSObject, FlutterStreamHandler {
    
	private var id: String
	private var _methodChannel: FlutterMethodChannel?
	private var _eventChannel: FlutterEventChannel?
	private var _eventSink: FlutterEventSink?
	
	init(id: String) {
		self.id = id
	}
	
	static func create(id: String, playerConfig: PlayerConfig?, messenger: FlutterBinaryMessenger) {
		let instance = PlayerMethod(id: id)
		instance._methodChannel = FlutterMethodChannel(name: "player-\(id)", binaryMessenger: messenger)
		instance._methodChannel?.setMethodCallHandler(instance.handleMethodCall)
		
		instance._eventChannel = FlutterEventChannel(name: "player-events-\(id)", binaryMessenger: messenger)
		instance._eventChannel?.setStreamHandler(instance)
		
		PlayerManager.shared.createPlayer(id: id, config: playerConfig)
	}
    
	public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
		self._eventSink = events
		let player = PlayerManager.shared.players[self.id]
		player?.add(listener: self)
		return nil
	}
	
	public func onCancel(withArguments arguments: Any?) -> FlutterError? {
		self._eventSink = nil
		return nil
	}
	
	private func getPlayer() -> Player? {
		return PlayerManager.shared.players[self.id]
	}
    
	private func handleMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult) {
		let payload = Helper.playerPayload(call.arguments)
		switch call.method {
			case "loadWithSourceConfig":
					let config: SourceConfig? = Helper.sourceConfig(payload.data)
					getPlayer()?.load(sourceConfig: config!)
					break;
			case "play":
					getPlayer()?.play()
					break;
			case "pause":
					getPlayer()?.pause()
					break;
			case "mute":
					getPlayer()?.mute()
					break;
			case "unmute":
					getPlayer()?.unmute()
					break;
			case "dispose":
					PlayerManager.shared.destroy(id: self.id)
					break;
			case "seek":
					getPlayer()?.seek(time: 1)
					break;
			case "current_time":
					result(getPlayer()?.currentTime)
					break;
			case "duration":
					result(getPlayer()?.duration)
					break;
			default:
					result(FlutterMethodNotImplemented)
		}
	}
}

extension PlayerMethod: PlayerListener {
	
	func _toJSONString(_ dictionary: [String: Any]) -> String? {
		do {
			let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [.prettyPrinted])
			if let jsonString = String(data: jsonData, encoding: .utf8) {
				return jsonString
			}
		} catch {
			print("Error converting dictionary to JSON string: \(error.localizedDescription)")
		}
		return nil
	}
	
	func _broadCast(sink: FlutterEventSink?, event: Event) {
		let target = [
			"event": event.name,
			"data": _toJSONString(event.toJSON())
		]
		sink?(_toJSONString(target as [String : Any]))
	}
	
	func onSourceLoad(_ event: SourceLoadEvent, player: Player) {
		_broadCast(sink: _eventSink, event: event)
	}
	
	func onSourceLoaded(_ event: SourceLoadedEvent, player: Player) {
		_broadCast(sink: _eventSink, event: event)
	}
	
	func onSourceUnLoad(_ event: SourceUnloadEvent, player: Player) {
		_broadCast(sink: _eventSink, event: event)
	}
	
	func onSourceWarning(_ event: SourceWarningEvent, player: Player) {
		_broadCast(sink: _eventSink, event: event)
	}
	
	func onSourceError(_ event: SourceErrorEvent, player: Player) {
		_broadCast(sink: _eventSink, event: event)
	}
	
	func onReady(_ event: ReadyEvent, player: Player) {
		_broadCast(sink: _eventSink, event: event)
	}
	
	func onDestroy(_ event: DestroyEvent, player: Player) {
		_broadCast(sink: _eventSink, event: event)
	}
	
	func onPlayerError(_ event: PlayerErrorEvent, player: Player) {
		_broadCast(sink: _eventSink, event: event)
	}
	
	func onPlayerWarning(_ event: PlayerWarningEvent, player: Player) {
		_broadCast(sink: _eventSink, event: event)
	}
	
	func onPlaybackFinished(_ event: PlaybackFinishedEvent, player: Player) {
		_broadCast(sink: _eventSink, event: event)
	}
	
	func onPlay(_ event: PlayEvent, player: Player) {
		_broadCast(sink: _eventSink, event: event)
	}
	
	func onPlaying(_ event: PlayingEvent, player: Player) {
		_broadCast(sink: _eventSink, event: event)
	}
	
	func onTimeChanged(_ event: TimeChangedEvent, player: Player) {
		_broadCast(sink: _eventSink, event: event)
	}
	
	func onPaused(_ event: PausedEvent, player: Player) {
		_broadCast(sink: _eventSink, event: event)
	}
	
	func onMuted(_ event: MutedEvent, player: Player) {
		_broadCast(sink: _eventSink, event: event)
	}
	
	func onUnmuted(_ event: UnmutedEvent, player: Player) {
		_broadCast(sink: _eventSink, event: event)
	}
	
	func onSeek(_ event: SeekEvent, player: Player) {
		_broadCast(sink: _eventSink, event: event)
	}
	
	func onSeeked(_ event: SeekedEvent, player: Player) {
		_broadCast(sink: _eventSink, event: event)
	}
}
