package com.bitmovin.player

import android.content.Context
import android.util.ArrayMap
import com.bitmovin.player.api.Player
import com.bitmovin.player.api.PlayerConfig
import io.flutter.Log

object PlayerManager {
    val players: ArrayMap<String, Player> = ArrayMap<String, Player>()
    fun create(
        id: String,
        context: Context,
        playerConfig: PlayerConfig?,
    ): Player {
        val target = if (playerConfig !== null) Player.create(context, playerConfig) else Player.create(context)
        players[id] = target
        return target
    }

    fun destroy(id: String) {
        val target = players[id]
        if (target != null) {
            if (target.isPlaying) {
                target.destroy()
            }
            players.remove(id)
        }
    }
}