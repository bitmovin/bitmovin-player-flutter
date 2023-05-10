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
        instance._methodChannel = FlutterMethodChannel(name: Channels.player + "-\(id)", binaryMessenger: messenger)
        instance._methodChannel?.setMethodCallHandler(instance.handleMethodCall)

        instance._eventChannel = FlutterEventChannel(name: Channels.playerEvent + "-\(id)", binaryMessenger: messenger)
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
        case Methods.LOAD_WITH_SOURCE_CONFIG:
            let config: SourceConfig? = Helper.sourceConfig(payload.data)
            getPlayer()?.load(sourceConfig: config!)
        case Methods.PLAY:
            getPlayer()?.play()
        case Methods.PAUSE:
            getPlayer()?.pause()
        case Methods.MUTE:
            getPlayer()?.mute()
        case Methods.UNMUTE:
            getPlayer()?.unmute()
        case Methods.SEEK:
            getPlayer()?.seek(time: 1)
        case Methods.CURRENT_TIME:
            result(getPlayer()?.currentTime)
        case Methods.DURATION:
            result(getPlayer()?.duration)
        case Methods.DESTROY:
            PlayerManager.shared.destroy(id: self.id)
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

    func _broadCast(name: String, data: [String: Any], sink: FlutterEventSink?) {
        let target = [
            "event": name,
            "data": _toJSONString(data)
        ]
        sink?(_toJSONString(target as [String: Any]))
    }

    func onSourceAdded(_ event: SourceAddedEvent, player: Player) {
        _broadCast(name: event.name, data: event.toJSON(), sink: _eventSink)
    }

    func onSourceRemoved(_ event: SourceRemovedEvent, player: Player) {
        _broadCast(name: event.name, data: event.toJSON(), sink: _eventSink)
    }

    func onSourceLoad(_ event: SourceLoadEvent, player: Player) {
        _broadCast(name: event.name, data: event.toJSON(), sink: _eventSink)
    }

    func onSourceLoaded(_ event: SourceLoadedEvent, player: Player) {
        _broadCast(name: event.name, data: event.toJSON(), sink: _eventSink)
    }

    func onSourceUnloaded(_ event: SourceUnloadedEvent, player: Player) {
        _broadCast(name: event.name, data: event.toJSON(), sink: _eventSink)
    }

    func onSourceUnLoad(_ event: SourceUnloadEvent, player: Player) {
        _broadCast(name: event.name, data: event.toJSON(), sink: _eventSink)
    }

    func onSourceWarning(_ event: SourceWarningEvent, player: Player) {
        _broadCast(name: event.name, data: event.toJSON(), sink: _eventSink)
    }

    func onSourceError(_ event: SourceErrorEvent, player: Player) {
        _broadCast(name: event.name, data: event.toJSON(), sink: _eventSink)
    }

    func onReady(_ event: ReadyEvent, player: Player) {
        _broadCast(name: event.name, data: event.toJSON(), sink: _eventSink)
    }

    func onDestroy(_ event: DestroyEvent, player: Player) {
        _broadCast(name: event.name, data: event.toJSON(), sink: _eventSink)
    }

    func onPlayerError(_ event: PlayerErrorEvent, player: Player) {
        _broadCast(name: event.name, data: event.toJSON(), sink: _eventSink)
    }

    func onPlayerWarning(_ event: PlayerWarningEvent, player: Player) {
        _broadCast(name: event.name, data: event.toJSON(), sink: _eventSink)
    }

    func onPlaybackFinished(_ event: PlaybackFinishedEvent, player: Player) {
        _broadCast(name: event.name, data: event.toJSON(), sink: _eventSink)
    }

    func onPlay(_ event: PlayEvent, player: Player) {
        _broadCast(name: event.name, data: event.toJSON(), sink: _eventSink)
    }

    func onPlaying(_ event: PlayingEvent, player: Player) {
        _broadCast(name: event.name, data: event.toJSON(), sink: _eventSink)
    }

    func onTimeChanged(_ event: TimeChangedEvent, player: Player) {
        _broadCast(name: event.name, data: event.toJSON(), sink: _eventSink)
    }

    func onPaused(_ event: PausedEvent, player: Player) {
        _broadCast(name: event.name, data: event.toJSON(), sink: _eventSink)
    }

    func onMuted(_ event: MutedEvent, player: Player) {
        _broadCast(name: event.name, data: event.toJSON(), sink: _eventSink)
    }

    func onUnmuted(_ event: UnmutedEvent, player: Player) {
        _broadCast(name: event.name, data: event.toJSON(), sink: _eventSink)
    }

    func onSeek(_ event: SeekEvent, player: Player) {
        _broadCast(name: event.name, data: event.toJSON(), sink: _eventSink)
    }

    func onSeeked(_ event: SeekedEvent, player: Player) {
        _broadCast(name: event.name, data: event.toJSON(), sink: _eventSink)
    }
}
