package com.bitmovin.player.flutter

import android.content.Context
import android.util.ArrayMap
import com.bitmovin.player.api.Player
import com.bitmovin.player.api.PlayerConfig

object PlayerManager {
    val players: ArrayMap<String, Player> = ArrayMap<String, Player>()
    fun create(
        id: String,
        context: Context,
        playerConfig: PlayerConfig?,
    ): Player {
        val target = playerConfig?.let { Player.create(context, it) } ?: Player.create(context)
        players[id] = target
        return target
    }

    fun destroy(id: String) {
        players[id]?.let {
            it.onStop()
            it.destroy()
            players.remove(id)
        }
    }
}
