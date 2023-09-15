package com.bitmovin.player.flutter

import com.bitmovin.player.PlayerView
import com.bitmovin.player.api.Player
import com.bitmovin.player.api.event.PlayerEvent
import com.bitmovin.player.api.event.SourceEvent
import com.fasterxml.jackson.databind.SerializationFeature
import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import io.flutter.plugin.common.EventChannel

open class EventListener {
    open var sink: EventChannel.EventSink? = null

    private fun broadcast(eventName: String, data: Any?) {
        data?.let {
            val mapper = jacksonObjectMapper()
            mapper.configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false)

            val payload = mapper.writeValueAsString(
                mapOf(
                    "event" to eventName,
                    "data" to data,
                ),
            )

            runOnMainThread { sink?.success(payload) }
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
                // TODO: might not work as the the subtitle track definition (side-loaded in source config) is different on Dart side
                broadcast("onSourceLoad", it)
            }
            on(SourceEvent.Loaded::class) {
                // TODO: might not work as the the subtitle track definition (side-loaded in source config) is different on Dart side
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
            on(PlayerEvent.TimeShift::class) {
                broadcast("onTimeShift", it)
            }
            on(PlayerEvent.TimeShifted::class) {
                broadcast("onTimeShifted", it)
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

    open fun listenToEvent(playerView: PlayerView) {
        with(playerView) {
            on(PlayerEvent.FullscreenEnter::class) {
                broadcast("onFullscreenEnter", it)
            }
            on(PlayerEvent.FullscreenExit::class) {
                broadcast("onFullscreenExit", it)
            }
        }
    }
}
