// Helper.kt
// Created by Vijae Manlapaz
package com.bitmovin.player.flutter

import android.content.Context
import android.content.Intent
import android.media.AudioManager
import android.net.Uri
import android.os.Build
import android.provider.Settings
import androidx.annotation.RequiresApi
import androidx.core.content.ContextCompat
import com.bitmovin.player.api.PlaybackConfig
import com.bitmovin.player.api.PlayerConfig
import com.bitmovin.player.api.SeekMode
import com.bitmovin.player.api.drm.DrmConfig
import com.bitmovin.player.api.drm.WidevineConfig
import com.bitmovin.player.api.media.MediaFilter
import com.bitmovin.player.api.source.Source
import com.bitmovin.player.api.source.SourceConfig
import com.bitmovin.player.api.source.SourceOptions
import com.bitmovin.player.api.source.SourceType
import com.bitmovin.player.api.ui.ScalingMode
import com.bitmovin.player.api.ui.StyleConfig
import com.bitmovin.player.flutter.drm.WidevineConfigMetadata

class Helper {
    companion object {
        fun parsePlayerPayload(params: Map<*, *>): PlayerPayload {
            return PlayerPayload(params["id"] as String, params["data"])
        }

        fun buildSource(params: Map<*, *>): Source {
            val sourceConfig = buildSourceConfig(params["sourceConfig"] as Map<*, *>)
            return Source.create(sourceConfig)
        }

        fun buildSourceConfig(params: Map<*, *>): SourceConfig {
            val drmConfig = params["drmConfig"] as? Map<*, *>

            return SourceConfig(
                url = params["url"] as String,
                type = buildSourceType(params["type"] as String),
                options = SourceOptions(),
                drmConfig = drmConfig?.let { buildDrmConfig(it) },
            )
        }

        private fun buildDrmConfig(params: Map<*, *>): DrmConfig? {
            return if (params["widevine"] is Map<*, *>) {
                buildWidevineConfig(params["widevine"] as Map<*, *>)
            } else {
                null
            }
        }

        private fun buildWidevineConfig(params: Map<*, *>): WidevineConfig {
            val widevineConfig = WidevineConfig(
                licenseUrl = params["licenseUrl"] as? String,
            )

            widevineConfig.preferredSecurityLevel = params["preferredSecurityLevel"] as? String
            widevineConfig.shouldKeepDrmSessionsAlive =
                params["shouldKeepDrmSessionsAlive"] as Boolean

            val httHeaders = params["httpHeaders"] as? Map<*, *>
            widevineConfig.httpHeaders = httHeaders
                ?.map { entry -> entry.key as? String to entry.value as? String }
                ?.toMap()
                ?.toMutableMap()

            return widevineConfig
        }

        /**
         * Builds a [WidevineConfigMetadata] object from the given `params` that tells which
         * callbacks of [WidevineConfig] are set on the Dart side.
         *
         * @param params The JSON data for [SourceConfig] or [Source].
         */
        fun buildWidevineConfigMetadata(params: Map<*, *>): WidevineConfigMetadata? {
            val params = params["sourceConfig"] as? Map<*, *> ?: params

            val drmConfig = params["drmConfig"] as? Map<*, *>
            val widevineConfig = drmConfig?.get("widevine") as? Map<*, *> ?: return null

            return WidevineConfigMetadata(
                widevineConfig["prepareMessage"] as? Boolean ?: false,
                widevineConfig["prepareLicense"] as? Boolean ?: false,
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
            return Settings.System.getInt(
                context.contentResolver,
                Settings.System.SCREEN_BRIGHTNESS,
                0,
            ).toFloat()
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
