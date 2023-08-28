import BitmovinPlayer
import Flutter
import Foundation

// Wraps a Bitmovin `PlayerView` and is connected to a player view instance that was created on the Flutter side in
// Dart. Communication with the player view instance on the Flutter side happens through the method channel.
class FlutterPlayerView: NSObject, FlutterPlatformView {
    struct Arguments: Codable {
        let playerId: String
        let hasFullscreenHandler: Bool
        let isFullscreen: Bool
    }

    private var rootView: UIView = UIView()
    private var playerView: PlayerView?
    private var methodChannel: FlutterMethodChannel
    private var fullscreenHandlerProxy: FullscreenHandlerProxy?

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
        methodChannel = FlutterMethodChannel(
            name: Channels.playerView + "-\(String(describing: viewIdentifier))",
            binaryMessenger: messenger
        )

        super.init()

        methodChannel.setMethodCallHandler(handleMethodCall)
        PlayerManager.shared.onPlayerCreated(id: arguments.playerId) { [weak self] player in
            self?.createPlayerView(
                player: player,
                hasFullscreenHandler: arguments.hasFullscreenHandler,
                isFullscreen: arguments.isFullscreen
            )
        }
    }

    func view() -> UIView {
        rootView
    }
}

private extension FlutterPlayerView {
    func handleMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case Methods.destroyPlayerView:
            destroyPlayerView()
        case Methods.enterFullscreen:
            playerView?.enterFullscreen()
        case Methods.exitFullscreen:
            playerView?.exitFullscreen()
        default:
            break
        }
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
        playerView?.removeFromSuperview()
        playerView = nil
    }
}
