import BitmovinPlayer
import Flutter
import Foundation

// Wraps a Bitmovin `PlayerView` and is connected to a player view instance that was created on the Flutter side in
// Dart. Communication with the player view instance on the Flutter side happens through the method channel.
internal class FlutterPlayerView: NSObject, FlutterPlatformView {
    struct Arguments: Codable {
        let playerId: String
        let hasFullscreenHandler: Bool
        let isFullscreen: Bool
        let playerViewConfig: FlutterPlayerViewConfig
    }

    private var rootView = UIView()
    private var playerView: PlayerView?
    private var methodChannel: FlutterMethodChannel
    private var eventChannel: FlutterEventChannel
    private var eventSink: FlutterEventSink?
    private var fullscreenHandlerProxy: FullscreenHandlerProxy?
    private let logger = getLogger()

    init(
        viewIdentifier: Int64,
        frame: CGRect,
        arguments: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
        guard let arguments = MessageDecoder.decode(type: Arguments.self, from: arguments) else {
            fatalError("Could not decode arguments for FlutterPlayerView.")
        }

        rootView = UIView()
        rootView.backgroundColor = UIColor.black

        let channelId = String(describing: viewIdentifier)
        methodChannel = FlutterMethodChannel(name: Channels.playerView + "-\(channelId)", binaryMessenger: messenger)
        eventChannel = FlutterEventChannel(name: Channels.playerViewEvent + "-\(channelId)", binaryMessenger: messenger)

        super.init()

        methodChannel.setMethodCallHandler(handleMethodCall)
        eventChannel.setStreamHandler(self)
        PlayerManager.shared.onPlayerCreated(id: arguments.playerId) { [weak self] player in
            Task { @MainActor [weak self] in
                self?.createPlayerView(
                    player: player,
                    hasFullscreenHandler: arguments.hasFullscreenHandler,
                    isFullscreen: arguments.isFullscreen,
                    playerViewConfig: arguments.playerViewConfig.toNative()
                )
            }
        }
    }

    func view() -> UIView {
        rootView
    }
}

extension FlutterPlayerView: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        Task { @MainActor in
            playerView?.add(listener: self)
        }
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.eventSink = nil
        Task { @MainActor in
            playerView?.remove(listener: self)
        }
        return nil
    }
}

@MainActor
private extension FlutterPlayerView {
    func handleMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult) {
        do {
            let methodCallResult = try handleMethodCall(call: call)
            result(methodCallResult)
        } catch let bitmovinError as BitmovinError {
            result(FlutterError.from(bitmovinError))
        } catch {
            result(
                FlutterError.general(
                    "Error while executing method call \"\(call.method)\": \(error.localizedDescription)"
                )
            )
        }
    }

    func handleMethodCall(call: FlutterMethodCall) throws -> Any? {
        switch call.method {
        case Methods.destroyPlayerView:
            destroyPlayerView()
        case Methods.enterFullscreen:
            playerView?.enterFullscreen()
        case Methods.exitFullscreen:
            playerView?.exitFullscreen()
        case Methods.isPictureInPicture:
            return playerView?.isPictureInPicture
        case Methods.isPictureInPictureAvailable:
            return playerView?.isPictureInPictureAvailable
        case Methods.enterPictureInPicture:
            playerView?.enterPictureInPicture()
        case Methods.exitPictureInPicture:
            playerView?.exitPictureInPicture()
        default:
            throw BitmovinError.unknownMethod(call.method)
        }

        // Returning `nil` here handles the case that a void method was called successfully.
        // If an error happened or we need to return a specific value, it needs to be handled explicitly
        return nil
    }

    func createPlayerView(
        player: Player,
        hasFullscreenHandler: Bool,
        isFullscreen: Bool,
        playerViewConfig: PlayerViewConfig = PlayerViewConfig()
    ) {
        let playerView = PlayerView(
            player: player,
            frame: UIView().bounds,
            playerViewConfig: playerViewConfig
        )
        playerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        rootView.addSubview(playerView)

        if hasFullscreenHandler {
            fullscreenHandlerProxy = FullscreenHandlerProxy(isFullscreen: isFullscreen, methodChannel: methodChannel)
            playerView.fullscreenHandler = fullscreenHandlerProxy
        }

        self.playerView = playerView
    }

    func destroyPlayerView() {
        methodChannel.setMethodCallHandler(nil)
        eventChannel.setStreamHandler(nil)
        playerView?.removeFromSuperview()
        playerView = nil
    }
}

extension FlutterPlayerView: UserInterfaceListener {
    private func broadcast(name: String, data: [String: Any], sink: FlutterEventSink?) {
        guard let sink else {
            logger.log("No event sink found", .error)
            return
        }

        let target: [String: Any] = [
            "event": name,
            "data": data
        ]

        guard let eventPayload = Helper.toJSONString(target) else {
            logger.log("Could not convert player view event to JSON string", .error)
            return
        }

        sink(eventPayload)
    }

    func onFullscreenEnter(_ event: FullscreenEnterEvent, view: PlayerView) {
        broadcast(name: event.name, data: event.toJsonFallback(), sink: eventSink)
    }

    func onFullscreenExit(_ event: FullscreenExitEvent, view: PlayerView) {
        broadcast(name: event.name, data: event.toJsonFallback(), sink: eventSink)
    }

    func onPictureInPictureEnter(_ event: PictureInPictureEnterEvent, view: PlayerView) {
        broadcast(name: event.name, data: event.toJsonFallback(), sink: eventSink)
    }

    func onPictureInPictureEntered(_ event: PictureInPictureEnteredEvent, view: PlayerView) {
        broadcast(name: event.name, data: event.toJsonFallback(), sink: eventSink)
    }

    func onPictureInPictureExit(_ event: PictureInPictureExitEvent, view: PlayerView) {
        broadcast(name: event.name, data: event.toJsonFallback(), sink: eventSink)
    }

    func onPictureInPictureExited(_ event: PictureInPictureExitedEvent, view: PlayerView) {
        broadcast(name: event.name, data: event.toJsonFallback(), sink: eventSink)
    }
}
