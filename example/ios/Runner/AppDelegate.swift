import AVKit
import Flutter
import UIKit

@UIApplicationMain
@objc
internal class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // configure for background audio
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
