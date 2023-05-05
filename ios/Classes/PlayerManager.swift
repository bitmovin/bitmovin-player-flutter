import BitmovinPlayer

public class PlayerManager {
  static let shared = PlayerManager()

  var players = [String: Player]()

  private init() {}

	func createPlayer(id: String, config: PlayerConfig?) {
		let player = PlayerFactory.create(playerConfig: config ?? PlayerConfig())
		players[id] = player
  }
    
	func destroy(id: String) {
		if let player = players[id] {
			player.destroy()
    	players.removeValue(forKey: id)
		}
	}
}
