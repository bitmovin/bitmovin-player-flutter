package com.bitmovin.player.flutter

import android.content.Context
import android.util.ArrayMap
import com.bitmovin.analytics.api.AnalyticsConfig
import com.bitmovin.analytics.api.DefaultMetadata
import com.bitmovin.player.api.Player
import com.bitmovin.player.api.PlayerConfig
import com.bitmovin.player.api.analytics.create

object PlayerManager {
    private val players = ArrayMap<String, Player>()

    // private val backgroundPlayers = ArrayMap<String, Player>()
    private val playerCallbacks = ArrayMap<String, Array<(Player) -> Unit>>()
    var backgroundPlayer: Player? = null
        private set

    fun create(
        id: String,
        context: Context,
        playerConfig: PlayerConfig?,
        analyticsConfig: AnalyticsConfig?,
        defaultMetadata: DefaultMetadata?,
        isBackgroundPlaybackEnabled: Boolean,
    ): Player {
        // TODO: Figure out how how we can decide if player should be reused or not
        val existingBackgroundPlayer = backgroundPlayer
        if (existingBackgroundPlayer != null) {
            // Resue already created background player
            postToMainThread { handleCallbacks(id, existingBackgroundPlayer) }
            return existingBackgroundPlayer
        }

        if (hasPlayer(id)) {
            destroy(id)
        }

        val player =
            when {
                playerConfig == null -> Player.create(context)
                analyticsConfig == null -> Player.create(context, playerConfig)
                defaultMetadata == null -> Player.create(context, playerConfig, analyticsConfig)
                else -> Player.create(context, playerConfig, analyticsConfig, defaultMetadata)
            }

        if (isBackgroundPlaybackEnabled) {
            backgroundPlayer = player
        } else {
            players[id] = player
        }

        postToMainThread { handleCallbacks(id, player) }

        return player
    }

    fun onPlayerCreated(
        id: String,
        onCreated: (Player) -> Unit,
    ) {
        val player = players[id] ?: backgroundPlayer
        if (player != null) {
            onCreated(player)
        } else {
            playerCallbacks[id] = playerCallbacks.getOrDefault(id, emptyArray()) + onCreated
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

    private fun handleCallbacks(
        id: String,
        player: Player,
    ) {
        playerCallbacks[id]?.forEach { it(player) }
        playerCallbacks.remove(id)
    }
}
