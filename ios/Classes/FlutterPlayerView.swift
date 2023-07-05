import BitmovinPlayer
import Flutter
import Foundation

// Wraps a Bitmovin `PlayerView` and is connected to a player view instance that was created on the Flutter side in
// Dart. Communication with the player view instance on the Flutter side happens through the method channel.
class FlutterPlayerView: NSObject, FlutterPlatformView {
    private var rootView: UIView = UIView()
    private var playerView: PlayerView?
    private var methodChannel: FlutterMethodChannel

    init(
        viewIdentifier: Int64,
        frame: CGRect,
        arguments: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
        guard let playerId = arguments as? String else {
            fatalError("Expected player ID as argument.")
        }

        rootView = UIView()
        rootView.backgroundColor = UIColor.black
        methodChannel = FlutterMethodChannel(
            name: Channels.playerView + "-\(String(describing: viewIdentifier))",
            binaryMessenger: messenger
        )

        super.init()

        methodChannel.setMethodCallHandler(handleMethodCall)
        PlayerManager.shared.onPlayerCreated(id: playerId) { [weak self] player in
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
        methodChannel.setMethodCallHandler(nil)
        playerView = nil
    }
}
