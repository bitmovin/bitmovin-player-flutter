import BitmovinPlayerAnalytics
import Flutter
import UIKit

public class PlayerPlugin: NSObject, FlutterPlugin {
    private let messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    // Main entry point for the iOS side of Bitmovin Player Flutter SDK
    public static func register(with registrar: FlutterPluginRegistrar) {
        let mainChannel = FlutterMethodChannel(name: Channels.main, binaryMessenger: registrar.messenger())

        let playerPlugin = PlayerPlugin(messenger: registrar.messenger())
        registrar.addMethodCallDelegate(playerPlugin, channel: mainChannel)

        let flutterPlayerViewFactory = FlutterPlayerViewFactory(messenger: registrar.messenger())
        registrar.register(flutterPlayerViewFactory, withId: Channels.playerView)
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
              let playerConfigJson = arguments["playerConfig"] as? [AnyHashable: Any] else {
            result(FlutterError())
            return
        }

        let config = Helper.playerConfig(playerConfigJson)

        let analyticsConfigJson = playerConfigJson["analyticsConfig"] as? [AnyHashable: Any]
        let defaultMetadataJson = analyticsConfigJson?["defaultMetadata"] as? [AnyHashable: Any]
        let analyticsConfig = MessageDecoder.toNative(type: FlutterAnalyticsConfig.self, from: analyticsConfigJson)
        let defaultMetadata = MessageDecoder.toNative(type: FlutterDefaultMetadata.self, from: defaultMetadataJson)

        // TODO: Maybe make this nicer. It is weird that we do not retain `FlutterPlayer` explicitly. It is only
        // retained by Flutter because it listens to method and event channels. Instead of storing player instance in
        // `PlayerManager` we could store `PlayerMethod` instance, that would make the code a bit more structured and
        // easier to grasp.
        _ = FlutterPlayer(
            id: id,
            playerConfig: config,
            analyticsConfig: analyticsConfig,
            defaultMetadata: defaultMetadata,
            messenger: messenger
        )
        result(true)
    }
}
