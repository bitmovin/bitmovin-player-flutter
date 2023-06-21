package com.bitmovin.core

import android.os.Handler
import android.os.Looper
import com.bitmovin.player.api.Player
import com.bitmovin.player.api.event.PlayerEvent
import com.bitmovin.player.api.event.SourceEvent
import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import io.flutter.plugin.common.EventChannel

open class EventListener {
    open var sink: EventChannel.EventSink? = null

    private fun broadcast(eventName: String, data: Any?) {
        data?.let {
            val mapper = jacksonObjectMapper()
            val payload = mapper.writeValueAsString(
                mapOf(
                    "event" to eventName,
                    "data" to mapper.writeValueAsString(data),
                ),
            )

            // TODO: nice way to solve this?
            if (Looper.myLooper() == Looper.getMainLooper()) {
                sink?.success(payload)
            } else {
                Handler(Looper.getMainLooper()).post {
                    sink?.success(payload)
                }
            }
        }
    }

    open fun listenToEvent(player: Player) {
        with(player) {
            /**
             * Source Events
             */
            on(SourceEvent.Warning::class) {
                val target = mapOf<String, Any?>(
                    "code" to it.code.value,
                    "message" to it.message,
                    "timestamp" to it.timestamp,
                )
                broadcast("onSourceWarning", target)
            }
            on(SourceEvent.Info::class) {
                broadcast("onSourceInfo", it)
            }
            on(SourceEvent.Error::class) {
                val target = mapOf<String, Any?>(
                    "code" to it.code.value,
                    "message" to it.message,
                    "timestamp" to it.timestamp,
                )
                broadcast("onSourceError", target)
            }
            on(SourceEvent.Load::class) {
                broadcast("onSourceLoad", it)
            }
            on(SourceEvent.Loaded::class) {
                broadcast("onSourceLoaded", it)
            }
            on(SourceEvent.Unloaded::class) {
                broadcast("onSourceUnloaded", it)
            }
            /**
             * Player Events
             */
            on(PlayerEvent.Ready::class) {
                broadcast("onReady", it)
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
            on(PlayerEvent.Info::class) {
                broadcast("onPlayerInfo", it)
            }
            on(PlayerEvent.Warning::class) {
                val target = mapOf<String, Any?>(
                    "code" to it.code.value,
                    "message" to it.message,
                    "timestamp" to it.timestamp,
                )
                broadcast("onPlayerWarning", target)
            }
            on(PlayerEvent.Error::class) {
                val target = mapOf<String, Any?>(
                    "code" to it.code.value,
                    "message" to it.message,
                    "timestamp" to it.timestamp,
                )
                broadcast("onPlayerError", target)
            }
        }
    }
}
