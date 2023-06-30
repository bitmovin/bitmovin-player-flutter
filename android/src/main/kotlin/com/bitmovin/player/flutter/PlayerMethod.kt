package com.bitmovin.player.flutter

import android.content.Context
import com.bitmovin.player.api.Player
import com.bitmovin.player.api.PlayerConfig
import com.bitmovin.player.api.drm.WidevineConfig
import com.bitmovin.player.api.source.Source
import com.bitmovin.player.flutter.drm.WidevineCallbacksHandler
import com.bitmovin.player.flutter.json.JMethodArgs
import com.bitmovin.player.flutter.json.JPlayerMethodArg
import com.bitmovin.player.flutter.json.JSourceConfig
import com.bitmovin.player.flutter.json.JsonMethodHandler
import com.bitmovin.player.flutter.json.metadata
import com.bitmovin.player.flutter.json.toNative
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.MethodChannel

class PlayerMethod(
    context: Context,
    private val id: String,
    messenger: BinaryMessenger,
    config: PlayerConfig?,
) : StreamHandler, EventListener() {
    @Suppress("unused")
    private val tag: String = this::class.java.simpleName
    private var widevineCallbacksHandler: WidevineCallbacksHandler? = null
    private val playerMethodChannel: MethodChannel

    init {
        ChannelManager.registerEventChannel(
            "${Channels.PLAYER_EVENT}-$id",
            this@PlayerMethod,
            messenger,
        )
        playerMethodChannel = ChannelManager.registerMethodChannel(
            "${Channels.PLAYER}-$id",
            JsonMethodHandler(this::onMethodCall),
            messenger,
        )
        PlayerManager.create(id, context, config)
    }

    private fun getPlayer(): Player? = PlayerManager.players[id]

    private fun Player.load(jSourceConfig: JSourceConfig) {
        val sourceConfig = jSourceConfig.toNative()
        val widevineConfig = sourceConfig.drmConfig as? WidevineConfig
        val widevineMetadata = jSourceConfig.drmConfig?.widevine?.metadata

        if (widevineConfig != null && widevineMetadata != null) {
            widevineCallbacksHandler = WidevineCallbacksHandler(
                widevineMetadata,
                widevineConfig,
                playerMethodChannel,
            )
        }

        load(Source.create(sourceConfig))
    }

    private fun Player.onMethodCall(method: String, arg: JPlayerMethodArg): Any = when (method) {
        Methods.LOAD_WITH_SOURCE_CONFIG -> load(arg.asSourceConfig)
        Methods.LOAD_WITH_SOURCE -> load(arg.asSource.sourceConfig)
        Methods.PLAY -> play()
        Methods.PAUSE -> pause()
        Methods.MUTE -> mute()
        Methods.UNMUTE -> unmute()
        Methods.SEEK -> seek(arg.asDouble)
        Methods.CURRENT_TIME -> currentTime
        Methods.DURATION -> duration
        Methods.DESTROY -> PlayerManager.destroy(id)
        else -> throw NotImplementedError()
    }

    private fun onMethodCall(method: String, arguments: JMethodArgs): Any {
        val player = getPlayer() ?: throw IllegalArgumentException("Player $id not found")
        return player.onMethodCall(method, arguments.asPlayerMethodArgs)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sink = events
        getPlayer()?.let {
            listenToEvent(it)
        }
    }

    override fun onCancel(arguments: Any?) {
        sink = null
    }
}
