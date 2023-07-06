package com.bitmovin.player.flutter

import android.content.Context
import android.util.ArrayMap
import com.bitmovin.player.api.Player
import com.bitmovin.player.api.PlayerConfig

object PlayerManager {
    private val players = ArrayMap<String, Player>()
    private val playerCallbacks = ArrayMap<String, Array<(Player) -> Unit>>()

    fun create(
        id: String,
        context: Context,
        playerConfig: PlayerConfig?,
    ): Player {
        if (hasPlayer(id)) {
            destroy(id)
        }

        val player = playerConfig?.let { Player.create(context, it) } ?: Player.create(context)
        players[id] = player

        postToMainThread { handleCallbacks(id, player) }

        return player
    }

    fun onPlayerCreated(id: String, onCreated: (Player) -> Unit) {
        players[id]?.let {
            onCreated(it)
        } ?: run {
            playerCallbacks[id] = playerCallbacks[id]?.plus(onCreated) ?: arrayOf(onCreated)
        }
    }

    private fun hasPlayer(id: String): Boolean = players.containsKey(id)

    fun destroy(id: String) {
        players[id]?.let {
            it.onStop()
            it.destroy()
            players.remove(id)
        }
    }

    private fun handleCallbacks(id: String, player: Player) {
        playerCallbacks[id]?.forEach { it(player) }
        playerCallbacks.remove(id)
    }
}
