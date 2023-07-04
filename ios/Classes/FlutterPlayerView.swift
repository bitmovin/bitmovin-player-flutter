import BitmovinPlayer
import Flutter
import Foundation

class FlutterPlayerView: NSObject, FlutterPlatformView {
    private var rootView: UIView = UIView()
    private var playerView: PlayerView?
    private var methodChannel: FlutterMethodChannel?

    init(
        viewIdentifier: Int64,
        frame: CGRect,
        arguments: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
        rootView = UIView()
        rootView.backgroundColor = UIColor.black

        super.init()

        guard let playerId = arguments as? String else {
            fatalError("Expected player ID as argument.")
        }

        let methodChannel = FlutterMethodChannel(
            name: Channels.playerView + "-\(String(describing: viewIdentifier))",
            binaryMessenger: messenger
        )
        methodChannel.setMethodCallHandler(self.handleMethodCall)
        self.methodChannel = methodChannel

        PlayerManager.shared.onPlayerCreated(playerId: playerId) { [weak self] player in
            self?.createPlayerView(player: player)
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
            break
        default:
            break
        }
    }

    func createPlayerView(player: Player, playerViewConfig: PlayerViewConfig = PlayerViewConfig()) {
        let playerView = PlayerView(
            player: player,
            frame: UIView().bounds,
            playerViewConfig: playerViewConfig
        )
        playerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        rootView.addSubview(playerView)

        self.playerView = playerView
    }

    func destroyPlayerView() {
        methodChannel?.setMethodCallHandler(nil)
        playerView = nil
    }
}
