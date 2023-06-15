import Flutter
import UIKit

public class PlayerPlugin: NSObject, FlutterPlugin {
    weak var registrar: FlutterPluginRegistrar?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let viewFactory = PlayerNativeViewFactory(messenger: registrar.messenger())
        registrar.register(viewFactory, withId: Channels.playerView)

        let instance = PlayerPlugin()
        instance.registrar = registrar

        let channel = FlutterMethodChannel(name: Channels.main, binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(instance, channel: channel)
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
        let _ = PlayerMethod(id: id, playerConfig: config, messenger: registrar.messenger())
        result(true)
    }
}
