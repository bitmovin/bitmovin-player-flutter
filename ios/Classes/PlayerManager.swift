import BitmovinPlayer
import BitmovinPlayerAnalytics

internal class PlayerManager {
    typealias PlayerCreated = (Player) -> Void

    static let shared = PlayerManager()
    private var players: [String: Player] = [:]
    private var playerCreatedCallbacks: [String: [PlayerCreated]] = [:]

    private init() {}

    func createPlayer(
        id: String,
        config: PlayerConfig?,
        analyticsConfig: AnalyticsConfig?,
        defaultMetadata: DefaultMetadata?
    ) -> Player {
        if hasPlayer(id: id) {
            destroy(id: id)
        }

        let player: Player
        if let analyticsConfig {
            player = PlayerFactory.create(
                playerConfig: config ?? PlayerConfig(),
                analyticsConfig: analyticsConfig,
                defaultMetadata: defaultMetadata ?? DefaultMetadata()
            )
        } else {
            player = PlayerFactory.create(playerConfig: config ?? PlayerConfig())
        }

        players[id] = player

        DispatchQueue.main.async { [weak self] in
            self?.handleCallbacks(id: id, player: player)
        }

        return player
    }

    func hasPlayer(id: String) -> Bool {
        players[id] != nil
    }

    func onPlayerCreated(id: String, onCreated: @escaping PlayerCreated) {
        if let player = players[id] {
            onCreated(player)
            return
        }

        if !playerCreatedCallbacks.keys.contains(id) {
            playerCreatedCallbacks[id] = []
        }

        playerCreatedCallbacks[id]?.append(onCreated)
    }

    func destroy(id: String) {
        if let player = players[id] {
            player.destroy()
            players.removeValue(forKey: id)
        }
    }
}

private extension PlayerManager {
    func handleCallbacks(id: String, player: Player) {
        guard let callbacks = playerCreatedCallbacks[id] else {
            return
        }

        playerCreatedCallbacks[id] = []
        callbacks.forEach {
            $0(player)
        }
    }
}
