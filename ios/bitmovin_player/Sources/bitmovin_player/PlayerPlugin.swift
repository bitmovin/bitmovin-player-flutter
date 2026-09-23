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
            result(FlutterError.general("Could not parse method call arguments: \(call.method)"))
            return
        }

        do {
            let methodCallResult = try handleMethodCall(method: call.method, arguments: arguments)
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

    private func handleMethodCall(method: String, arguments: [String: Any]) throws -> Any? {
        switch method {
        case Methods.createPlayer:
            try handleCreatePlayer(arguments: arguments)
            return true
        case Methods.castManagerInitialize:
            if let options = MessageDecoder.toNative(type: FlutterBitmovinCastManagerOptions.self, from: arguments) {
                BitmovinCastManager.initializeCasting(options: options)
            } else {
                throw BitmovinError.parsingError("Could not parse arguments for \(method)")
            }
        case Methods.castManagerSendMessage:
            if let args = MessageDecoder.decode(type: BitmovinCastManagerSendMessageArgs.self, from: arguments) {
                BitmovinCastManager.sharedInstance().sendMessage(args.message, withNamespace: args.messageNamespace)
            } else {
                throw BitmovinError.parsingError("Could not parse arguments for \(method)")
            }
        default:
            throw BitmovinError.unknownMethod(method)
        }

        // Returning `nil` here handles the case that a void method was called successfully.
        // If an error happened or we need to return a specific value, it needs to be handled explicitly
        return nil
    }

    private func handleCreatePlayer(arguments: [String: Any]) throws {
        guard let id = arguments["id"] as? String,
              let playerConfigJson = arguments["playerConfig"] as? [AnyHashable: Any] else {
            throw BitmovinError.parsingError("Could not parse arguments to create player instance")
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
    }
}
