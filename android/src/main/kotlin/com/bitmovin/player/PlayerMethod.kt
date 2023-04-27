package com.bitmovin.player

import android.content.Context
import android.util.Log
import com.bitmovin.Helper
import com.bitmovin.PlayerPayload
import com.bitmovin.player.api.Player
import com.bitmovin.player.api.PlayerConfig
import com.bitmovin.player.api.event.Event
import com.bitmovin.player.api.event.PlayerEvent
import com.bitmovin.player.api.event.SourceEvent
import com.bitmovin.player.api.source.Source
import com.bitmovin.player.api.source.SourceConfig
import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import kotlin.reflect.KClass

class PlayerMethod(
    context: Context,
    private val id: String,
    messenger: BinaryMessenger,
    config: PlayerConfig?
) : MethodCallHandler, StreamHandler {
    private val tag: String = this::class.java.simpleName
    private var sink: EventChannel.EventSink? = null

    init {
        EventChannel(messenger, "player-events-$id").apply {
            this.setStreamHandler(this@PlayerMethod)
        }
        MethodChannel(messenger,"player-$id").apply {
            this.setMethodCallHandler(this@PlayerMethod)
        }
        PlayerManager.create(id, context, config)
    }

    private fun <E : Event> broadcast(eventClass: KClass<E>, data: Any?) {
        data?.let {
            val mapper = jacksonObjectMapper();
            val name = eventClass.qualifiedName
            val regexp = "(?<=\\.)\\w+\$".toRegex()
            val payload = mapper.writeValueAsString(mapOf(
                "event" to regexp.find(name as CharSequence)?.value,
                "data" to mapper.writeValueAsString(data),
            ))
            sink?.success(payload)
        }
    }

    private fun broadcast(eventName: String, data: Any?) {
        data?.let {
            val mapper = jacksonObjectMapper();
            val payload = mapper.writeValueAsString(mapOf(
                "event" to eventName,
                "data" to mapper.writeValueAsString(data),
            ))
            sink?.success(payload)
        }
    }

    private fun listenToEvent(player: Player) {
        with (player) {
            /**
             * Source Events
             */
            on(SourceEvent.Unloaded::class) {
                broadcast("onSourceUnloaded", it)
            }
            on(SourceEvent.Warning::class) {
                broadcast("onSourceWarning", it)
            }
            on(SourceEvent.Info::class) {
                broadcast("onSourceInfo", it)
            }
            on(SourceEvent.Error::class) {
                broadcast("onSourceError", it)
            }
            on(SourceEvent.Load::class) {
                broadcast("onSourceLoad", it)
            }
            on(SourceEvent.Loaded::class) {
                broadcast("onSourceLoaded", it)
            }
            on(SourceEvent.Unloaded::class) {
                broadcast("onSourceUnLoaded", it)
            }
            /**
             * Player Events
             */
            on(PlayerEvent.Ready::class) {
                broadcast("onReady", it)
            }
            on(PlayerEvent.Warning::class) {
                broadcast("onWarning", it)
            }
            on(PlayerEvent.Error::class) {
                broadcast("onError", it)
            }
            on(PlayerEvent.PlaybackFinished::class) {
                broadcast("onPlaybackFinished", it)
            }
            on(PlayerEvent.SourceAdded::class) {
                broadcast("onSourceAdded", it)
            }
            on(PlayerEvent.SourceRemoved::class) {
                broadcast("onSourceRemoved", it)
            }
            on(PlayerEvent.TimeChanged::class) {
                broadcast("onTimeChanged", it)
            }
            on(PlayerEvent.Playing::class) {
                broadcast("onPlaying", it)
            }
            on(PlayerEvent.Play::class) {
                broadcast("onPlay", it)
            }
            on(PlayerEvent.Paused::class) {
                broadcast("onPaused", it)
            }
            on(PlayerEvent.Muted::class) {
                broadcast("onMuted", it)
            }
            on(PlayerEvent.Unmuted::class) {
                broadcast("onUnmuted", it)
            }
            on(PlayerEvent.Seek::class) {
                broadcast("onSeek", it)
            }
            on(PlayerEvent.Seeked::class) {
                broadcast("onSeeked", it)
            }
            on(PlayerEvent.Warning::class) {
                broadcast("onWarning", it)
            }
            on(PlayerEvent.Error::class) {
                broadcast("onError", it)
            }
        }
    }

    private fun getPlayer() : Player {
        return PlayerManager.players[id]!!
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val params = call.arguments as Map<*, *>
        val payload: PlayerPayload = Helper.parsePlayerPayload(params)

        Log.e(tag, "CHANNEL ==> player-$id")

        when (call.method) {
            "loadWithSourceConfig" -> {
                val sourceConfig: SourceConfig = Helper.buildSourceConfig(payload.data as Map<*, *>)
                getPlayer().load(sourceConfig)
            }
            "loadWithSource" -> {
                val source: Source = Helper.buildSource(payload.data as Map<*, *>)
                getPlayer().load(source)
            }
            "play" -> getPlayer().play()
            "pause" -> getPlayer().pause()
            "mute" -> getPlayer().mute()
            "unmute" -> getPlayer().unmute()
            "destroy" -> PlayerManager.destroy(id)
            "seek" -> getPlayer().seek(payload.data as Double)
            "current_time" -> result.success(getPlayer().currentTime)
            "duration" -> result.success(getPlayer().duration)
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sink = events
        listenToEvent(getPlayer())
    }

    override fun onCancel(arguments: Any?) {
        sink = null
    }
}