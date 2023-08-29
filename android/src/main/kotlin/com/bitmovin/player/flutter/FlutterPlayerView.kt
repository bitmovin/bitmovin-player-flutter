package com.bitmovin.player.flutter

import android.content.Context
import android.view.View
import com.bitmovin.player.PlayerView
import com.bitmovin.player.api.Player
import com.bitmovin.player.flutter.json.JPlayerViewCreateArgs
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
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
) : MethodChannel.MethodCallHandler, EventChannel.StreamHandler, PlatformView, EventListener() {
    private val playerView: PlayerView
    private val methodChannel: MethodChannel = MethodChannel(
        messenger,
        "${Channels.PLAYER_VIEW}-$id",
    ).apply { setMethodCallHandler(this@FlutterPlayerView) }
    private val eventChannel = ChannelManager.registerEventChannel(
        "${Channels.PLAYER_VIEW_EVENT}-$id",
        this@FlutterPlayerView,
        messenger,
    )

    init {
        val playerViewCreateArgs = JPlayerViewCreateArgs(args as Map<*, *>)

        playerView = PlayerView(context, null as Player?)
        PlayerManager.onPlayerCreated(playerViewCreateArgs.playerId) { player ->
            playerView.player = player
            if (playerViewCreateArgs.hasFullscreenHandler) {
                playerView.setFullscreenHandler(
                    FullscreenHandlerProxy(
                        isFullscreen = playerViewCreateArgs.isFullscreen,
                        methodChannel = methodChannel,
                    ),
                )
            }
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) = when (call.method) {
        Methods.ENTER_FULLSCREEN -> playerView.enterFullscreen()
        Methods.EXIT_FULLSCREEN -> playerView.exitFullscreen()
        Methods.DESTROY_PLAYER_VIEW -> { /* no-op */ }
        else -> throw NotImplementedError()
    }

    override fun getView(): View = playerView

    override fun dispose() {
        playerView.player = null
        playerView.onDestroy()
        methodChannel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sink = events
        listenToEvent(playerView)
    }

    override fun onCancel(arguments: Any?) {
        sink = null
    }
}
