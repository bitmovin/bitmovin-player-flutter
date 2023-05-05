package com.bitmovin.player

import android.content.Context
import com.bitmovin.ChannelManager
import com.bitmovin.Helper
import com.bitmovin.core.Channels
import com.bitmovin.core.EventListener
import com.bitmovin.core.PlayerPayload
import com.bitmovin.core.data.Methods
import com.bitmovin.player.api.Player
import com.bitmovin.player.api.PlayerConfig
import com.bitmovin.player.api.source.Source
import com.bitmovin.player.api.source.SourceConfig
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

class PlayerMethod(
    context: Context,
    private val id: String,
    messenger: BinaryMessenger,
    config: PlayerConfig?
) : MethodCallHandler, StreamHandler, EventListener() {
    @Suppress("unused")
    private val tag: String = this::class.java.simpleName

    init {
//        EventChannel(messenger, "player-events-$id").apply {
//            this.setStreamHandler(this@PlayerMethod)
//        }
//        MethodChannel(messenger,"player-$id").apply {
//            this.setMethodCallHandler(this@PlayerMethod)
//        }
        ChannelManager.registerEventChannel("${Channels.PLAYER_EVENT}-$id", this@PlayerMethod, messenger)
        ChannelManager.registerMethodChannel("${Channels.PLAYER}-$id", this@PlayerMethod, messenger)
        PlayerManager.create(id, context, config)
    }

    private fun getPlayer() : Player? = PlayerManager.players[id]

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val params = call.arguments as Map<*, *>
        val payload: PlayerPayload = Helper.parsePlayerPayload(params)
        when (call.method) {
            Methods.LOAD_WITH_SOURCE_CONFIG -> {
                payload.data?.let {
                    val sourceConfig: SourceConfig = Helper.buildSourceConfig(it as Map<*, *>)
                    getPlayer()?.load(sourceConfig)
                }
            }
            Methods.LOAD_WITH_SOURCE -> {
                payload.data?.let {
                    val source: Source = Helper.buildSource(it as Map<*, *>)
                    getPlayer()?.load(source)
                }
            }
            Methods.PLAY -> getPlayer()?.play()
            Methods.PAUSE -> getPlayer()?.pause()
            Methods.MUTE -> getPlayer()?.mute()
            Methods.UNMUTE -> getPlayer()?.unmute()
            Methods.SEEK -> getPlayer()?.seek(payload.data as Double)
            Methods.CURRENT_TIME -> result.success(getPlayer()?.currentTime)
            Methods.DURATION -> result.success(getPlayer()?.duration)
            Methods.DESTROY -> PlayerManager.destroy(id)
        }
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