package com.bitmovin.player.flutter.json

import com.bitmovin.analytics.api.AnalyticsConfig
import com.bitmovin.analytics.api.CustomData
import com.bitmovin.analytics.api.DefaultMetadata
import com.bitmovin.analytics.api.SourceMetadata
import com.bitmovin.player.api.LicensingConfig
import com.bitmovin.player.api.PlaybackConfig
import com.bitmovin.player.api.PlayerConfig
import com.bitmovin.player.api.casting.RemoteControlConfig
import com.bitmovin.player.api.drm.DrmConfig
import com.bitmovin.player.api.drm.WidevineConfig
import com.bitmovin.player.api.live.LiveConfig
import com.bitmovin.player.api.media.subtitle.SubtitleTrack
import com.bitmovin.player.api.source.SourceConfig
import com.bitmovin.player.api.source.SourceOptions
import com.bitmovin.player.api.source.SourceType
import com.bitmovin.player.api.ui.ScalingMode
import com.bitmovin.player.api.ui.StyleConfig
import com.bitmovin.player.flutter.drm.WidevineConfigMetadata

// Build Native objects from the corresponding Json object

internal fun JSourceConfig.toNative() =
    SourceConfig(
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
        subtitleTracks.forEach { sourceConfig.addSubtitleTrack(it.toNative()) }
    }

internal fun JSourceMetadata.toNative() =
    SourceMetadata
        .Builder()
        .apply {
            cdnProvider?.let { setCdnProvider(it) }
            isLive?.let { setIsLive(it) }
            path?.let { setPath(it) }
            title?.let { setTitle(it) }
            videoId?.let { setVideoId(it) }
            customData?.let { setCustomData(it.toNative()) }
        }.build()

internal fun JSourceOptions.toNative() =
    SourceOptions(
        startOffset = startOffset,
        startOffsetTimelineReference = startOffsetTimelineReference,
    )

private fun JDrmConfig.toNative(): DrmConfig? = widevine?.toNative()

private fun JWidevineConfig.toNative() =
    WidevineConfig(licenseUrl).also {
        it.preferredSecurityLevel = preferredSecurityLevel
        it.shouldKeepDrmSessionsAlive = shouldKeepDrmSessionsAlive ?: false
        it.httpHeaders = httpHeaders?.toMutableMap()
    }

internal val JWidevineConfig.metadata: WidevineConfigMetadata
    get() = WidevineConfigMetadata(prepareMessage ?: false, prepareLicense ?: false)

internal fun JPlayerConfig.toNative() =
    PlayerConfig(key = key).also { config ->
        styleConfig?.let { config.styleConfig = it.toNative() }
        playbackConfig?.let { config.playbackConfig = it.toNative() }
        licensingConfig?.let { config.licensingConfig = it.toNative() }
        liveConfig?.let { config.liveConfig = it.toNative() }
        remoteControlConfig?.let { config.remoteControlConfig = it.toNative() }
    }

internal fun JAnalyticsConfig.toNative(): AnalyticsConfig =
    AnalyticsConfig
        .Builder(licenseKey = licenseKey)
        .apply {
            adTrackingDisabled?.let { setAdTrackingDisabled(it) }
            backendUrl?.let { setBackendUrl(it) }
            randomizeUserId?.let { setRandomizeUserId(it) }
            retryPolicy?.let { setRetryPolicy(it) }
        }.build()

internal fun JDefaultMetadata.toNative(): DefaultMetadata =
    DefaultMetadata
        .Builder()
        .apply {
            cdnProvider?.let { setCdnProvider(it) }
            customData?.let { setCustomData(it.toNative()) }
            customUserId?.let { setCustomUserId(it) }
            customData?.let { setCustomData(it.toNative()) }
        }.build()

internal fun JCustomData.toNative(): CustomData =
    CustomData
        .Builder()
        .apply {
            customData1?.let { setCustomData1(it) }
            customData2?.let { setCustomData2(it) }
            customData3?.let { setCustomData3(it) }
            customData4?.let { setCustomData4(it) }
            customData5?.let { setCustomData5(it) }
            customData6?.let { setCustomData6(it) }
            customData7?.let { setCustomData7(it) }
            customData8?.let { setCustomData8(it) }
            customData9?.let { setCustomData9(it) }
            customData10?.let { setCustomData10(it) }
            customData11?.let { setCustomData11(it) }
            customData12?.let { setCustomData12(it) }
            customData13?.let { setCustomData13(it) }
            customData14?.let { setCustomData14(it) }
            customData15?.let { setCustomData15(it) }
            customData16?.let { setCustomData16(it) }
            customData17?.let { setCustomData17(it) }
            customData18?.let { setCustomData18(it) }
            customData19?.let { setCustomData19(it) }
            customData20?.let { setCustomData20(it) }
            customData21?.let { setCustomData21(it) }
            customData22?.let { setCustomData22(it) }
            customData23?.let { setCustomData23(it) }
            customData24?.let { setCustomData24(it) }
            customData25?.let { setCustomData25(it) }
            customData26?.let { setCustomData26(it) }
            customData27?.let { setCustomData27(it) }
            customData28?.let { setCustomData28(it) }
            customData29?.let { setCustomData29(it) }
            customData30?.let { setCustomData30(it) }
            experimentName?.let { setExperimentName(it) }
        }.build()

internal fun JStyleConfig.toNative() =
    StyleConfig(
        scalingMode = scalingMode ?: ScalingMode.Fit,
        supplementalPlayerUiCss = supplementalPlayerUiCss,
    ).also { config ->
        isUiEnabled?.let { config.isUiEnabled = it }
        isHideFirstFrame?.let { config.isHideFirstFrame = it }
        playerUiCss?.let { config.playerUiCss = it }
        playerUiJs?.let { config.playerUiJs = it }
    }

internal fun JPlaybackConfig.toNative() =
    PlaybackConfig().also { config ->
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

internal fun JLicensingConfig.toNative() =
    LicensingConfig().also { config ->
        delay?.let { config.delay = it }
    }

internal fun JLiveConfig.toNative() =
    LiveConfig().also { config ->
        minTimeShiftBufferDepth?.let { config.minTimeShiftBufferDepth = it }
        liveEdgeOffset?.let { config.liveEdgeOffset = it }
    }

internal fun JRemoteControlConfig.toNative() =
    RemoteControlConfig().also { config ->
        receiverStylesheetUrl?.let { config.receiverStylesheetUrl = it }
        customReceiverConfig?.let { config.customReceiverConfig = it }
        isCastEnabled?.let { config.isCastEnabled = it }
        sendManifestRequestsWithCredentials?.let { config.sendManifestRequestsWithCredentials = it }
        sendSegmentRequestsWithCredentials?.let { config.sendSegmentRequestsWithCredentials = it }
        sendDrmLicenseRequestsWithCredentials?.let {
            config.sendDrmLicenseRequestsWithCredentials = it
        }
    }

internal fun JSubtitleTrack.toNative() =
    SubtitleTrack(
        url = url,
        label = label,
        id = id,
        mimeType = format,
        isDefault = isDefault,
        isForced = isForced,
        language = language,
    )
