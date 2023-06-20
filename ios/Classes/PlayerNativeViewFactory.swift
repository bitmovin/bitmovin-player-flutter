import Flutter
import UIKit

class PlayerNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(registrar: FlutterPluginRegistrar) {
        self.messenger = registrar.messenger()

        super.init()

        registrar.register(self, withId: Channels.playerView)
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return PlayerViewMethod(
            viewIdentifier: viewId,
            frame: frame,
            arguments: args,
            binaryMessenger: messenger
        )
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}
