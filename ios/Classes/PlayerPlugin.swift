import Flutter
import UIKit

public class PlayerPlugin: NSObject, FlutterPlugin {
	weak var registrar: FlutterPluginRegistrar?
	
  public static func register(with registrar: FlutterPluginRegistrar) {
		
		let viewFactory = PlayerNativeViewFactory(messenger: registrar.messenger())
		registrar.register(viewFactory, withId: "player-view")
		
		let instance = PlayerPlugin()
		instance.registrar = registrar
		
    let channel = FlutterMethodChannel(name: "channel-manager", binaryMessenger: registrar.messenger())
    registrar.addMethodCallDelegate(instance, channel: channel)
  }


  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
	
		let arguments = call.arguments as? [String : Any]
		
		if (call.method == "CREATE_PLAYER") {
			let config = Helper.playerConfig(arguments?["playerConfig"] as? [AnyHashable: Any])
			let id = arguments?["id"] as! String
			
			PlayerMethod.create(id: id, playerConfig: config, messenger: registrar!.messenger())
				
			result(true)
		}
  }
}
