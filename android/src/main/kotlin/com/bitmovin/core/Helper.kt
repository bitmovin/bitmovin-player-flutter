// Helper.kt
// Created by Vijae Manlapaz
package com.bitmovin.core

import android.content.Context
import android.content.Intent
import android.media.AudioManager
import android.net.Uri
import android.provider.Settings
import androidx.core.content.ContextCompat
import com.bitmovin.player.api.PlaybackConfig
import com.bitmovin.player.api.SeekMode
import com.bitmovin.player.api.event.PlayerEvent
import com.bitmovin.player.api.event.SourceEvent
import com.bitmovin.player.api.media.MediaFilter
import com.bitmovin.core.data.EventPayload
import com.bitmovin.core.data.EventType
import com.bitmovin.player.api.PlayerConfig
import com.bitmovin.player.api.source.Source
import com.bitmovin.player.api.source.SourceConfig
import com.bitmovin.player.api.source.SourceOptions
import com.bitmovin.player.api.source.SourceType
import com.bitmovin.player.api.ui.ScalingMode
import com.bitmovin.player.api.ui.StyleConfig

class Helper {
    companion object {
        fun parseSourceEventWarningPayload(payload: SourceEvent.Warning, type: EventType) : Map<String, Any> {
            return mapOf(
                "code" to payload.code.name,
                "message" to payload.message,
                "type" to type.printableName,
            )
        }
        fun parseSourceEventErrorPayload(payload: SourceEvent.Error, type: EventType) : Map<String, Any?> {
            return mapOf(
                "code" to payload.code.name,
                "message" to payload.message,
                "data" to payload.data.toString(),
                "type" to type.printableName,
            )
        }
        fun parsePlayerEventWarningPayload(payload: PlayerEvent.Warning, type: EventType) : Map<String, Any> {
            return mapOf(
                "code" to payload.code.name,
                "message" to payload.message,
                "type" to type.printableName,
            )
        }
        fun parsePlayerEventErrorPayload(payload: PlayerEvent.Error, type: EventType) : Map<String, Any?> {
            return mapOf(
                "code" to payload.code.name,
                "message" to payload.message,
                "data" to payload.data.toString(),
                "type" to type.printableName,
            )
        }
         fun parsePlayerEventPayload(payload: EventPayload): Map<String, Any?> {
            return mapOf(
                "type" to payload.type.printableName,
                "duration" to payload.duration,
                "currentTime" to payload.currentTime,
            )
        }
        fun parsePlaybackConfig(playbackConfig: Map<*, *>) : PlaybackConfig {
            return PlaybackConfig(
                isAutoplayEnabled = playbackConfig["isAutoPlay"] as Boolean,
                isMuted = playbackConfig["isMuted"] as Boolean,
                isTimeShiftEnabled = playbackConfig["isTimeShifted"] as Boolean,
                videoCodecPriority = (playbackConfig["videoCodecPriority"] as List<*>).map { it as String },
                audioCodecPriority = (playbackConfig["audioCodecPriority"] as List<*>).map { it as String },
                seekMode = SeekMode.values().first {
                    when (playbackConfig["seekMode"] as String) {
                        "exact" -> true
                        "closesSync" -> true
                        "nextSync" -> true
                        "previousSync" -> true
                        else -> false
                    }
                },
                audioFilter = MediaFilter.values().first {
                    when (playbackConfig["videoFilter"] as String) {
                        "exact" -> true
                        "loose" -> true
                        "strict" -> true
                        else -> false
                    }
                },
                videoFilter = MediaFilter.values().first {
                    when (playbackConfig["videoFilter"] as String) {
                        "exact" -> true
                        "loose" -> true
                        "strict" -> true
                        else -> false
                    }
                },
            )
        }

        //    private fun buildPlaylistConfig(params: Map<*, *>): PlaylistConfig {
//        val sources: Array<Source> = arrayOf(params["sources"] as Source)
//        val options = mapOf(params["options"] as Pair<*, *>)
//        return PlaylistConfig(sources = sources.toList(), options = buildPlaylistOptions(options))
//    }

//    private fun buildPlaylistOptions(params: Map<*, *>): PlaylistOptions {
//        val preloadSource: Boolean = params["preloadSources"] as Boolean
//        val replayMode: ReplayMode = params["replayMode"] as ReplayMode
//        return PlaylistOptions(preloadAllSources = preloadSource, replayMode = replayMode)
//    }

        fun buildSource(params: Map<*, *>): Source {
            Source
            return Source.create(buildSourceConfig(params))
        }

        fun buildSourceConfig(params: Map<*, *>): SourceConfig {
            return SourceConfig(
                url = params["url"] as String,
                type = SourceType.valueOf(params["type"] as String),
                options = SourceOptions(),
            )
        }

        fun buildStyleConfig(params: Map<*, *>): StyleConfig {
            return StyleConfig(
                isUiEnabled = params["isUiEnabled"] as Boolean,
                isHideFirstFrame = params["isHideFirstFrame"] as Boolean,
                scalingMode = ScalingMode.valueOf("Fit"),
                supplementalPlayerUiCss = params["supplementalPlayerUiCss"] as String?,
            )
        }

        fun buildPlaybackConfig(params: Map<*, *>): PlaybackConfig {
            return PlaybackConfig(
                isAutoplayEnabled = params["isAutoplayEnabled"] as Boolean,
                isMuted = params["isMuted"] as Boolean,
                isTimeShiftEnabled = params["isTimeShiftEnabled"] as Boolean,
                isTunneledPlaybackEnabled = params["isTunneledPlaybackEnabled"] as Boolean,
                audioCodecPriority = (params["audioCodecPriority"] as List<*>).map { it as String },
                videoCodecPriority = (params["videoCodecPriority"] as List<*>).map { it as String },
                audioFilter = MediaFilter.valueOf(params["audioFilter"] as String),
                videoFilter = MediaFilter.valueOf(params["videoFilter"] as String),
                forcedSubtitleCallback = null,
                seekMode = SeekMode.valueOf(params["seekMode"] as String)
            )
        }

        fun buildPlayerConfig(params: Map<*, *>): PlayerConfig {
            val styleConfig = params["styleConfig"] as Map<*, *>
            val buildPlaybackConfig = params["playbackConfig"] as Map<*, *>
            return PlayerConfig(
                key = params["key"] as String?,
                styleConfig = buildStyleConfig(styleConfig),
                playbackConfig = buildPlaybackConfig(buildPlaybackConfig)
            )
        }

        fun secondsToMillis(seconds: Double) : Double = seconds * 1000
        fun millisToSeconds(millis: Double) : Double = millis / 1000
        fun normalize(
            x: Float,
            inMin: Float,
            inMax: Float,
            outMin: Float,
            outMax: Float
        ): Float {
            val outRange = outMax - outMin
            val inRange = inMax - inMin
            return (x - inMin) * outRange / inRange + outMin
        }
        fun getSystemBrightness(context: Context) : Float {
            return Settings.System.getInt(context.contentResolver, Settings.System.SCREEN_BRIGHTNESS, 0).toFloat()
        }
        fun canWriteSystemSettings(context: Context) : Boolean {
            return Settings.System.canWrite(context)
        }
        fun requestSystemWritePermission(context: Context) {
            val intent = Intent(Settings.ACTION_MANAGE_WRITE_SETTINGS).apply {
                data = Uri.parse("package:" + context.packageName)
            }
            ContextCompat.startActivity(context, intent, null)
        }
        fun getAudio(context: Context) : AudioManager {
            return context.getSystemService(Context.AUDIO_SERVICE) as AudioManager;
        }
    }
}