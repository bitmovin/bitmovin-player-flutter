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
        let player = players[id]
        if ((player?.isPlaying) != nil) {
            player?.destroy()
            
            let target = players.index(forKey: id)
            players.remove(at: target!)
        }
    }
}
