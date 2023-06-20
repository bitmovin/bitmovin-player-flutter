import Foundation
import Flutter
import BitmovinPlayer

// TODO: Refactor this class
class PlayerViewMethod: NSObject, FlutterPlatformView {
    private var viewIdentifier: Int64?
    private var frame: CGRect?
    private var messenger: FlutterBinaryMessenger?
    private var arguments: Any?

    private var _view: UIView = UIView()
    private var _playerView: PlayerView?
    private var _player: Player?
    private var _methodChannel: FlutterMethodChannel?

    init(
        viewIdentifier: Int64,
        frame: CGRect,
        arguments: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
        self._view = UIView()
        super.init()

        self.viewIdentifier = viewIdentifier
        self.frame = frame
        self.messenger = messenger
        self.arguments = arguments
        self._methodChannel = FlutterMethodChannel(
            name: Channels.playerView + "-\(String(describing: viewIdentifier))",
            binaryMessenger: messenger
        )
        self._methodChannel?.setMethodCallHandler(self.handleMethodCall)
    }

    private func createPlayerView(playerId: String, playerViewConfig: PlayerViewConfig?) {
        _playerView = PlayerView(
            player: PlayerManager.shared.players[playerId]!,
            frame: UIView().bounds,
            playerViewConfig: playerViewConfig ?? PlayerViewConfig()
        )
        _playerView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        _view.addSubview(_playerView!)
    }

    func view() -> UIView {
        _view.backgroundColor = UIColor.black
        return _view
    }

    private func handleMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any?] else { return }

        if call.method == Methods.bindPlayer, let playerId = args["playerId"] as? String {
            createPlayerView(playerId: playerId, playerViewConfig: nil)
        }
    }
}
