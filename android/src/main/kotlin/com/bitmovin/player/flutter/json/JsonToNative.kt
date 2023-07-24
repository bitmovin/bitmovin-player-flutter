package com.bitmovin.player.flutter.json

import com.bitmovin.player.api.LicensingConfig
import com.bitmovin.player.api.PlaybackConfig
import com.bitmovin.player.api.PlayerConfig
import com.bitmovin.player.api.drm.DrmConfig
import com.bitmovin.player.api.drm.WidevineConfig
import com.bitmovin.player.api.live.LiveConfig
import com.bitmovin.player.api.source.SourceConfig
import com.bitmovin.player.api.source.SourceOptions
import com.bitmovin.player.api.source.SourceType
import com.bitmovin.player.api.ui.ScalingMode
import com.bitmovin.player.api.ui.StyleConfig
import com.bitmovin.player.flutter.drm.WidevineConfigMetadata

// Build Native objects from the corresponding Json object

internal fun JSourceConfig.toNative() = SourceConfig(
    url = url,
    type = type ?: SourceType.Progressive,
    title = title,
    description = description,
    posterSource = posterSource,
    options = options?.toNative() ?: SourceOptions(),
    drmConfig = drmConfig?.toNative(),
).also { sourceConfig ->
    audioCodecPriority?.let { sourceConfig.audioCodecPriority = it }
    videoCodecPriority?.let { sourceConfig.videoCodecPriority = it }
    isPosterPersistent?.let { sourceConfig.isPosterPersistent = it }
}

internal fun JSourceOptions.toNative() = SourceOptions(
    startOffset = startOffset,
    startOffsetTimelineReference = startOffsetTimelineReference,
)

private fun JDrmConfig.toNative(): DrmConfig? = widevine?.toNative()
private fun JWidevineConfig.toNative() = WidevineConfig(licenseUrl).also {
    it.preferredSecurityLevel = preferredSecurityLevel
    it.shouldKeepDrmSessionsAlive = shouldKeepDrmSessionsAlive ?: false
    it.httpHeaders = httpHeaders?.toMutableMap()
}

internal val JWidevineConfig.metadata: WidevineConfigMetadata
    get() = WidevineConfigMetadata(prepareMessage ?: false, prepareLicense ?: false)

internal fun JPlayerConfig.toNative() = PlayerConfig(key = key).also { config ->
    styleConfig?.let { config.styleConfig = it.toNative() }
    playbackConfig?.let { config.playbackConfig = it.toNative() }
    licensingConfig?.let { config.licensingConfig = it.toNative() }
    liveConfig?.let { config.liveConfig = it.toNative() }
}

internal fun JStyleConfig.toNative() = StyleConfig(
    scalingMode = scalingMode ?: ScalingMode.Fit,
    supplementalPlayerUiCss = supplementalPlayerUiCss,
).also { config ->
    isUiEnabled?.let { config.isUiEnabled = it }
    isHideFirstFrame?.let { config.isHideFirstFrame = it }
    playerUiCss?.let { config.playerUiCss = it }
    playerUiJs?.let { config.playerUiJs = it }
}

internal fun JPlaybackConfig.toNative() = PlaybackConfig().also { config ->
    isAutoplayEnabled?.let { config.isAutoplayEnabled = it }
    isMuted?.let { config.isMuted = it }
    isTimeShiftEnabled?.let { config.isTimeShiftEnabled = it }
    isTunneledPlaybackEnabled?.let { config.isTunneledPlaybackEnabled = it }
    audioCodecPriority?.let { config.audioCodecPriority = it }
    videoCodecPriority?.let { config.videoCodecPriority = it }
    audioFilter?.let { config.audioFilter = it }
    videoFilter?.let { config.videoFilter = it }
    seekMode?.let { config.seekMode = it }
}

internal fun JLicensingConfig.toNative() = LicensingConfig().also { config ->
    delay?.let { config.delay = it }
}

internal fun JLiveConfig.toNative() = LiveConfig().also { config ->
    minTimeShiftBufferDepth?.let { config.minTimeShiftBufferDepth = it }
    liveEdgeOffset?.let { config.liveEdgeOffset = it }
}
