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
    private let logger = getLogger()

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
        let methodCallResult = handleMethodCall(call: call)
        result(methodCallResult)
    }

    func handleMethodCall(call: FlutterMethodCall) -> Any? {
        guard let arguments = Helper.methodCallArguments(call.arguments) else {
            return FlutterError()
        }

        switch (call.method, arguments) {
        case (Methods.loadWithSourceConfig, .json(let sourceConfigJson)):
            if let (sourceConfig, metadata) = Helper.sourceConfig(sourceConfigJson) {
                handleLoadWithSourceConfig(sourceConfig, metadata: metadata)
            } else {
                return FlutterError()
            }
        case (Methods.loadWithSource, .json(let sourceJson)):
            if let (source, metadata) = Helper.source(sourceJson) {
                handleLoadWithSourceConfig(source.sourceConfig, metadata: metadata)
            } else {
                return FlutterError()
            }
        case (Methods.play, .empty):
            player.play()
        case (Methods.pause, .empty):
            player.pause()
        case (Methods.mute, .empty):
            player.mute()
        case (Methods.unmute, .empty):
            player.unmute()
        case (Methods.seek, .double(let seekTarget)):
            player.seek(time: seekTarget)
        case (Methods.currentTime, .empty):
            return player.currentTime
        case (Methods.duration, .empty):
            return player.duration
        case (Methods.getTimeShift, .empty):
            return player.timeShift
        case (Methods.setTimeShift, .double(let timeShiftTarget)):
            player.timeShift = timeShiftTarget
        case (Methods.maxTimeShift, .empty):
            return player.maxTimeShift
        case (Methods.isLive, .empty):
            return player.isLive
        case (Methods.isPlaying, .empty):
            return player.isPlaying
        case (Methods.destroy, .empty):
            destroyPlayer()
        default:
            return FlutterMethodNotImplemented
        }

        // Returning `nil` here handles the case that a void method was called successfully.
        // If an error happened or we need to return a specific value, it needs to be handled explicitly
        return nil
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
    private func broadCast(name: String, data: [String: Any], sink: FlutterEventSink?) {
        guard let sink else {
            logger.log("No event sink found", .error)
            return
        }

        let target: [String: Any] = [
            "event": name,
            "data": data
        ]

        guard let eventPayload = Helper.toJSONString(target) else {
            logger.log("Could not convert player event to JSON string", .error)
            return
        }

        sink(eventPayload)
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

    func onTimeShift(_ event: TimeShiftEvent, player: Player) {
        broadCast(name: event.name, data: event.toJSON(), sink: eventSink)
    }

    func onTimeShifted(_ event: TimeShiftedEvent, player: Player) {
        broadCast(name: event.name, data: event.toJSON(), sink: eventSink)
    }
}
