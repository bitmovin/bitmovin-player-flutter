import BitmovinPlayer
import Flutter
import Foundation

internal class FullscreenHandlerProxy: NSObject, FullscreenHandler {
    private(set) var isFullscreen: Bool
    private let methodChannel: FlutterMethodChannel

    init(
        isFullscreen: Bool,
        methodChannel: FlutterMethodChannel
    ) {
        self.isFullscreen = isFullscreen
        self.methodChannel = methodChannel
    }

    func onFullscreenRequested() {
        isFullscreen = true
        methodChannel.invokeMethod(Methods.enterFullscreen, arguments: nil)
    }

    func onFullscreenExitRequested() {
        isFullscreen = false
        methodChannel.invokeMethod(Methods.exitFullscreen, arguments: nil)
    }
}
