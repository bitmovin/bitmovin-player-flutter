package com.bitmovin.player

import android.content.Context
import android.view.View
import com.bitmovin.core.Channels
import com.bitmovin.core.data.Methods
import com.bitmovin.player.api.Player
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView

class PlayerViewMethod(
    context: Context,
    messenger: BinaryMessenger,
    id: Int,
) : MethodChannel.MethodCallHandler, PlatformView {
    @Suppress("unused")
    private val tag: String = this::class.java.simpleName
    private var view: PlayerView
    private var playerId: String? = null

    init {
        MethodChannel(
            messenger,
            "${Channels.PLAYER_VIEW}-$id",
        ).apply {
            this.setMethodCallHandler(this@PlayerViewMethod)
        }
        view = PlayerView(context)
    }

    private fun setPlayer(player: Player) {
        view.player = player
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val params = call.arguments as Map<*, *>
        playerId = params["playerId"] as String
        when (call.method) {
            Methods.BIND_PLAYER -> {
                PlayerManager.players[playerId]?.let {
                    setPlayer(it)
                }
            }
            Methods.UNBIND_PLAYER -> {
                dispose()
            }
        }
    }

    override fun getView(): View {
        return view
    }

    override fun dispose() {
        view.player = null
        playerId?.let {
            PlayerManager.destroy(it)
        }
    }
}
