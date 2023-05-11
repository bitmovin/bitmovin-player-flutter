// Helper.kt
// Created by Vijae Manlapaz
package com.bitmovin

import android.content.Context
import android.content.Intent
import android.media.AudioManager
import android.net.Uri
import android.os.Build
import android.provider.Settings
import androidx.annotation.RequiresApi
import androidx.core.content.ContextCompat
import com.bitmovin.core.PlayerPayload
import com.bitmovin.player.api.PlaybackConfig
import com.bitmovin.player.api.PlayerConfig
import com.bitmovin.player.api.SeekMode
import com.bitmovin.player.api.media.MediaFilter
import com.bitmovin.player.api.source.Source
import com.bitmovin.player.api.source.SourceConfig
import com.bitmovin.player.api.source.SourceOptions
import com.bitmovin.player.api.source.SourceType
import com.bitmovin.player.api.ui.ScalingMode
import com.bitmovin.player.api.ui.StyleConfig

class Helper {
    companion object {
        fun parsePlayerPayload(params: Map<*, *>): PlayerPayload {
            return PlayerPayload(params["id"] as String, params["data"])
        }

        fun buildSource(params: Map<*, *>): Source {
            return Source.create(buildSourceConfig(params))
        }

        fun buildSourceConfig(params: Map<*, *>): SourceConfig {
            return SourceConfig(
                url = params["url"] as String,
                type = buildSourceType(params["type"] as String),
                options = SourceOptions(),
            )
        }

        fun buildSourceConfigFromUrl(url: String): SourceConfig {
            return SourceConfig.fromUrl(url)
        }

        fun buildSourceType(type: String): SourceType {
            return when (type) {
                "dash" -> SourceType.Dash
                "hls" -> SourceType.Hls
                "smooth" -> SourceType.Smooth
                "progressive" -> SourceType.Progressive
                else -> SourceType.Progressive
            }
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
                seekMode = SeekMode.valueOf(params["seekMode"] as String),
            )
        }

        fun buildPlayerConfig(params: Map<*, *>?): PlayerConfig? {
            return params?.let {
                val styleConfig = params["styleConfig"] as Map<*, *>
                val buildPlaybackConfig = params["playbackConfig"] as Map<*, *>
                return PlayerConfig(
                    key = params["key"] as String?,
                    styleConfig = buildStyleConfig(styleConfig),
                    playbackConfig = buildPlaybackConfig(buildPlaybackConfig),
                )
            }
        }

        fun secondsToMillis(seconds: Double): Double = seconds * 1000

        fun millisToSeconds(millis: Double): Double = millis / 1000

        fun normalize(
            x: Float,
            inMin: Float,
            inMax: Float,
            outMin: Float,
            outMax: Float,
        ): Float {
            val outRange = outMax - outMin
            val inRange = inMax - inMin
            return (x - inMin) * outRange / inRange + outMin
        }

        fun getSystemBrightness(context: Context): Float {
            return Settings.System.getInt(context.contentResolver, Settings.System.SCREEN_BRIGHTNESS, 0).toFloat()
        }

        @RequiresApi(Build.VERSION_CODES.M)
        fun canWriteSystemSettings(context: Context): Boolean {
            return Settings.System.canWrite(context)
        }

        fun requestSystemWritePermission(context: Context) {
            val intent = Intent(Settings.ACTION_MANAGE_WRITE_SETTINGS).apply {
                data = Uri.parse("package:" + context.packageName)
            }
            ContextCompat.startActivity(context, intent, null)
        }

        fun getAudio(context: Context): AudioManager {
            return context.getSystemService(Context.AUDIO_SERVICE) as AudioManager
        }
    }
}
