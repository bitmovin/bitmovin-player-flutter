package com.bitmovin.player.flutter

import android.content.Context
import android.view.View
import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.LifecycleOwner
import com.bitmovin.player.PlayerView
import com.bitmovin.player.flutter.json.JPlayerViewCreateArgs
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity
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
    private val activity = context.requireActivity()
    private val playerView: PlayerView = PlayerView(context, player = null)
    private val methodChannel: MethodChannel =
        MethodChannel(
            messenger,
            "${Channels.PLAYER_VIEW}-$id",
        ).apply { setMethodCallHandler(this@FlutterPlayerView) }
    private val eventChannel =
        ChannelManager.registerEventChannel(
            "${Channels.PLAYER_VIEW_EVENT}-$id",
            this@FlutterPlayerView,
            messenger,
        )

    private val activityLifecycle =
        activity.let { it as? FlutterActivity ?: it as? FlutterFragmentActivity }
            ?.lifecycle
            ?: error(
                "Trying to create an instance of ${this::class.simpleName}" +
                    " while not attached to a FlutterActivity or FlutterFragmentActivity",
            )

    private val activityLifecycleObserver =
        object : DefaultLifecycleObserver {
            override fun onStart(owner: LifecycleOwner) {
                playerView.onStart()
            }

            override fun onResume(owner: LifecycleOwner) {
                playerView.onResume()
            }

            override fun onPause(owner: LifecycleOwner) {
                playerView.onPause()
            }

            override fun onStop(owner: LifecycleOwner) {
                playerView.onStop()
            }

            override fun onDestroy(owner: LifecycleOwner) = dispose()
        }

    init {
        val playerViewCreateArgs = JPlayerViewCreateArgs(args as Map<*, *>)

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

        activityLifecycle.addObserver(activityLifecycleObserver)
    }

    override fun onMethodCall(
        call: MethodCall,
        result: MethodChannel.Result,
    ) = when (call.method) {
        Methods.ENTER_FULLSCREEN -> playerView.enterFullscreen()
        Methods.EXIT_FULLSCREEN -> playerView.exitFullscreen()
        Methods.DESTROY_PLAYER_VIEW -> Unit // no-op
        else -> throw NotImplementedError()
    }

    override fun getView(): View = playerView

    override fun dispose() {
        playerView.player = null
        playerView.onDestroy()
        methodChannel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)
        activityLifecycle.removeObserver(activityLifecycleObserver)
    }

    override fun onListen(
        arguments: Any?,
        events: EventChannel.EventSink?,
    ) {
        sink = events
        listenToEvent(playerView)
    }

    override fun onCancel(arguments: Any?) {
        sink = null
    }
}
