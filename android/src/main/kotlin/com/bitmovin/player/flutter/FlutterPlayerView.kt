package com.bitmovin.player.flutter

import android.content.Context
import android.view.View
import com.bitmovin.player.PlayerView
import com.bitmovin.player.api.Player
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView

/**
 * Wraps a Bitmovin `PlayerView` and is connected to a player view instance that was created on the
 * Flutter side in Dart. Communication with the player view instance on the Flutter side happens
 * through the method channel.
 */
class FlutterPlayerView(
    context: Context,
    messenger: BinaryMessenger,
    id: Int,
    args: Any?,
) : MethodChannel.MethodCallHandler, PlatformView {
    private val playerView: PlayerView
    private val methodChannel: MethodChannel = MethodChannel(
        messenger,
        "${Channels.PLAYER_VIEW}-$id",
    ).apply { setMethodCallHandler(this@FlutterPlayerView) }

    init {
        val playerId = args as? String ?: throw IllegalArgumentException("Expected player ID as argument.")

        playerView = PlayerView(context, null as Player?)
        PlayerManager.onPlayerCreated(playerId) { player ->
            playerView.player = player
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {}

    override fun getView(): View = playerView

    override fun dispose() {
        playerView.player = null
        playerView.onDestroy()
        methodChannel.setMethodCallHandler(null)
    }
}
