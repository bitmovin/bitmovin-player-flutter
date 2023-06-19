import Flutter
import UIKit

public class PlayerPlugin: NSObject, FlutterPlugin {
    weak var registrar: FlutterPluginRegistrar?

    public init(registrar: FlutterPluginRegistrar) {
        self.registrar = registrar

        super.init()

        let channel = FlutterMethodChannel(name: Channels.main, binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(self, channel: channel)
    }

    public static func register(with registrar: FlutterPluginRegistrar) {
        let _ = PlayerNativeViewFactory(registrar: registrar)
        let _ = PlayerPlugin(registrar: registrar)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = call.arguments as? [String: Any] else {
            result(FlutterError())
            return
        }

        if call.method == Methods.createPlayer {
            handleCreatePlayer(arguments: arguments, result: result)
        }
    }

    private func handleCreatePlayer(arguments: [String: Any], result: @escaping FlutterResult) {
        guard let id = arguments["id"] as? String,
              let playerConfigJson = arguments["playerConfig"] as? [AnyHashable: Any],
              let registrar else {
            result(FlutterError())
            return
        }

        let config = Helper.playerConfig(playerConfigJson)
        // TODO: Maybe make this nicer. It is weird that we do not retain `PlayerMethod` explicitly. It is only retained
        // by Flutter because it listens to method and event channels. Instead of storing player instance in
        // `PlayerManager` we could store `PlayerMethod` instance, that would make the code a bit more structured and
        // easier to grasp.
        let _ = PlayerMethod(id: id, playerConfig: config, messenger: registrar.messenger())
        result(true)
    }
}
