import BitmovinPlayer
import Flutter
import Foundation

// Wraps a Bitmovin `Player` and is connected to a player instance that was created on the Flutter side in Dart.
// Communication with the player instance on the Flutter side happens through the method channel.
// Player events are communicated to the Flutter side through the event channel.
class FlutterPlayer: NSObject {
    private var id: String
    private var eventSink: FlutterEventSink?
    private var methodChannel: FlutterMethodChannel
    private var eventChannel: FlutterEventChannel
    private var fairplayCallbacksHandler: FairplayCallbacksHandler?
    private let player: Player

    init(
        id: String,
        playerConfig: PlayerConfig,
        messenger: FlutterBinaryMessenger
    ) {
        self.id = id
        methodChannel = FlutterMethodChannel(name: Channels.player + "-\(id)", binaryMessenger: messenger)
        eventChannel = FlutterEventChannel(name: Channels.playerEvent + "-\(id)", binaryMessenger: messenger)
        player = PlayerManager.shared.createPlayer(id: id, config: playerConfig)

        super.init()

        methodChannel.setMethodCallHandler(handleMethodCall)
        eventChannel.setStreamHandler(self)
    }
}

extension FlutterPlayer: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        player.add(listener: self)
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        player.remove(listener: self)
        self.eventSink = nil
        return nil
    }
}

private extension FlutterPlayer {
    func handleMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let payload = Helper.playerPayload(call.arguments) else {
            result(FlutterError())
            return
        }

        switch call.method {
        case Methods.loadWithSourceConfig:
            if let payloadData = payload.data,
               let (sourceConfig, metadata) = Helper.sourceConfig(payloadData) {
                handleLoadWithSourceConfig(sourceConfig, metadata: metadata)
            } else {
                result(FlutterError())
            }
        case Methods.loadWithSource:
            if let payloadData = payload.data,
               let (source, metadata) = Helper.source(payloadData) {
                handleLoadWithSourceConfig(source.sourceConfig, metadata: metadata)
            } else {
                result(FlutterError())
            }
        case Methods.play:
            player.play()
        case Methods.pause:
            player.pause()
        case Methods.mute:
            player.mute()
        case Methods.unmute:
            player.unmute()
        case Methods.seek:
            // TODO: pass correct argument
            player.seek(time: 1)
        case Methods.currentTime:
            result(player.currentTime)
        case Methods.duration:
            result(player.duration)
        case Methods.destroy:
            destroyPlayer()
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    func handleLoadWithSourceConfig(
        _ sourceConfig: SourceConfig,
        metadata: FairplayConfig.Metadata?
    ) {
        if let fairplayConfig = sourceConfig.drmConfig as? FairplayConfig, let metadata {
            self.fairplayCallbacksHandler = FairplayCallbacksHandler(
                fairplayConfig: fairplayConfig,
                metadata: metadata,
                methodChannel: methodChannel
            )
        }

        player.load(sourceConfig: sourceConfig)
    }

    func destroyPlayer() {
        PlayerManager.shared.destroy(id: id)
        methodChannel.setMethodCallHandler(nil)
        eventChannel.setStreamHandler(nil)
    }
}

extension FlutterPlayer: PlayerListener {
    func toJSONString(_ dictionary: [String: Any]) -> String? {
        guard JSONSerialization.isValidJSONObject(dictionary) else {
            // TODO: fix all runtime occurrences of this error
            print("[error] invalid json object found")
            return nil
        }

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [.prettyPrinted])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            print("[error] converting dictionary to JSON string: \(error.localizedDescription)")
        }
        return nil
    }

    func broadCast(name: String, data: [String: Any], sink: FlutterEventSink?) {
        guard let sink else {
            print("[error] no sink found")
            return
        }

        let target = [
            "event": name,
            "data": toJSONString(data)
        ]

        sink(toJSONString(target as [String: Any]))
    }

    func onSourceAdded(_ event: SourceAddedEvent, player: Player) {
        broadCast(name: event.name, data: event.toJSON(), sink: eventSink)
    }

    func onSourceRemoved(_ event: SourceRemovedEvent, player: Player) {
        broadCast(name: event.name, data: event.toJSON(), sink: eventSink)
    }

    func onSourceLoad(_ event: SourceLoadEvent, player: Player) {
        broadCast(name: event.name, data: event.toJSON(), sink: eventSink)
    }

    func onSourceLoaded(_ event: SourceLoadedEvent, player: Player) {
        broadCast(name: event.name, data: event.toJSON(), sink: eventSink)
    }

    func onSourceUnloaded(_ event: SourceUnloadedEvent, player: Player) {
        broadCast(name: event.name, data: event.toJSON(), sink: eventSink)
    }

    func onSourceUnload(_ event: SourceUnloadEvent, player: Player) {
        broadCast(name: event.name, data: event.toJSON(), sink: eventSink)
    }

    func onSourceWarning(_ event: SourceWarningEvent, player: Player) {
        broadCast(name: event.name, data: event.toJSON(), sink: eventSink)
    }

    func onSourceError(_ event: SourceErrorEvent, player: Player) {
        broadCast(name: event.name, data: event.toJSON(), sink: eventSink)
    }

    func onReady(_ event: ReadyEvent, player: Player) {
        broadCast(name: event.name, data: event.toJSON(), sink: eventSink)
    }

    func onDestroy(_ event: DestroyEvent, player: Player) {
        broadCast(name: event.name, data: event.toJSON(), sink: eventSink)
    }

    func onPlayerError(_ event: PlayerErrorEvent, player: Player) {
        broadCast(name: event.name, data: event.toJSON(), sink: eventSink)
    }

    func onPlayerWarning(_ event: PlayerWarningEvent, player: Player) {
        broadCast(name: event.name, data: event.toJSON(), sink: eventSink)
    }

    func onPlaybackFinished(_ event: PlaybackFinishedEvent, player: Player) {
        broadCast(name: event.name, data: event.toJSON(), sink: eventSink)
    }

    func onPlay(_ event: PlayEvent, player: Player) {
        broadCast(name: event.name, data: event.toJSON(), sink: eventSink)
    }

    func onPlaying(_ event: PlayingEvent, player: Player) {
        broadCast(name: event.name, data: event.toJSON(), sink: eventSink)
    }

    func onTimeChanged(_ event: TimeChangedEvent, player: Player) {
        broadCast(name: event.name, data: event.toJSON(), sink: eventSink)
    }

    func onPaused(_ event: PausedEvent, player: Player) {
        broadCast(name: event.name, data: event.toJSON(), sink: eventSink)
    }

    func onMuted(_ event: MutedEvent, player: Player) {
        broadCast(name: event.name, data: event.toJSON(), sink: eventSink)
    }

    func onUnmuted(_ event: UnmutedEvent, player: Player) {
        broadCast(name: event.name, data: event.toJSON(), sink: eventSink)
    }

    func onSeek(_ event: SeekEvent, player: Player) {
        broadCast(name: event.name, data: event.toJSON(), sink: eventSink)
    }

    func onSeeked(_ event: SeekedEvent, player: Player) {
        broadCast(name: event.name, data: event.toJSON(), sink: eventSink)
    }
}
