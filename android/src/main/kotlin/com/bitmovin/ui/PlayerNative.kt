// PlayerNative.kt
// Created by Vijae Manlapaz
package com.bitmovin.ui

import android.content.Context
import com.bitmovin.core.Channel
import com.bitmovin.core.Helper
import com.bitmovin.player.api.Player
import com.bitmovin.player.api.event.Event
import com.bitmovin.player.api.event.PlayerEvent
import com.bitmovin.player.api.event.SourceEvent
import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.*
import kotlin.reflect.KClass

class PlayerNative(
    context: Context?,
    creationParams: Map<String, Any>?,
    messenger: BinaryMessenger,
    viewId: Int,
) : EventListener, MethodChannel.MethodCallHandler, EventChannel.StreamHandler {
    private val tag: String = PlayerNative::class.java.simpleName
    private var methodChannel: MethodChannel? = null
    private var eventChannel: EventChannel? = null
    private var streamListener: EventChannel.EventSink? = null
    var player: Player

    init {
        eventChannel = EventChannel(messenger,"${Channel.EVENTS}-$viewId").apply { 
            this.setStreamHandler(this@PlayerNative)
        }
        methodChannel = MethodChannel(messenger, "${Channel.METHODS}-$viewId").apply {
          this.setMethodCallHandler(this@PlayerNative)
        }
        if (context == null) { throw Exception("Context is null")}
        if (creationParams == null) throw Exception("No parameters defined")

        this.player = Player.create(context, Helper.buildPlayerConfig(creationParams["playerConfig"] as Map<*, *>)).apply {
            listen(this)
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "play" -> player.play()
            "pause" -> player.pause()
            "mute" -> player.mute()
            "unmute" -> player.unmute()
            "preload" -> player.preload()
            "loadWithSourceConfig" -> player.load(Helper.buildSourceConfig(call.arguments as Map<*, *>))
            "loadWithSource" -> player.load(Helper.buildSource(call.arguments as Map<*, *>))
            "unload" -> player.unload()
        }
    }

    private fun listen(player: Player) {
        with(player) {
            on(SourceEvent.DrmDataParsed::class) {
                invokeEvent(it::class, it)
            }
            on(SourceEvent.MetadataParsed::class) {
                invokeEvent(it::class, it)
            }
            on(SourceEvent.Warning::class) {
                invokeEvent(it::class, it)
            }
            on(SourceEvent.Error::class) {
                invokeEvent(it::class, it)
            }
            on(SourceEvent.Load::class) {
                invokeEvent(it::class, it)
            }
            on(SourceEvent.Loaded::class) {
                invokeEvent(it::class, it)
            }
            on(SourceEvent.Unloaded::class) {
                invokeEvent(it::class, it)
            }
            on(PlayerEvent.Warning::class) {
                invokeEvent(it::class, it)
            }
            on(PlayerEvent.Error::class) {
                invokeEvent(it::class, it)
            }
            on(PlayerEvent.LicenseValidated::class) {
                invokeEvent(it::class, it)
            }
            on(PlayerEvent.Metadata::class) {
                invokeEvent(it::class, it)
            }
            on(PlayerEvent.Ready::class) {
                invokeEvent(it::class, it)
            }
            on(PlayerEvent.Playing::class) {
                invokeEvent(it::class, it)
            }
            on(PlayerEvent.Unmuted::class) {
                invokeEvent(it::class, it)
            }
            on(PlayerEvent.TimeChanged::class) {
                invokeEvent(it::class, it)
            }
            on(PlayerEvent.Play::class) {
                invokeEvent(it::class, it)
            }
            on(PlayerEvent.Paused::class) {
                invokeEvent(it::class, it)
            }
            on(PlayerEvent.StallStarted::class) {
                invokeEvent(it::class, it)
            }
            on(PlayerEvent.StallEnded::class) {
                invokeEvent(it::class, it)
            }
            on(PlayerEvent.PlaybackFinished::class) {
                invokeEvent(it::class, it)
            }
            on(PlayerEvent.Seeked::class) {
                invokeEvent(it::class, it)
            }
        }
    }

    private fun broadcast(event: String?, data: Any?) {
        data?.let {
            val mapper = jacksonObjectMapper().writeValueAsString(data)

            val regexp = "(?<=\\.)\\w+\$".toRegex()
            streamListener?.success(mapOf<String, Any?>(
                "event" to regexp.find(event as CharSequence)?.value,
                "data" to mapper,
            ))
        }
    }

    private fun <E : Event> invokeEvent(eventClass: KClass<E>, data: Any?) {
        broadcast(eventClass.qualifiedName, data)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        streamListener = events
    }

    override fun onCancel(arguments: Any?) {
        streamListener = null
    }
}