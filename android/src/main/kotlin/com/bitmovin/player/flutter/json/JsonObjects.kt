package com.bitmovin.player.flutter.json

import com.bitmovin.analytics.api.RetryPolicy
import com.bitmovin.player.api.Player
import com.bitmovin.player.api.SeekMode
import com.bitmovin.player.api.media.MediaFilter
import com.bitmovin.player.api.media.subtitle.SubtitleTrack
import com.bitmovin.player.api.source.SourceType
import com.bitmovin.player.api.source.TimelineReferencePoint
import com.bitmovin.player.api.ui.ScalingMode
import com.bitmovin.player.casting.BitmovinCastManager
import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import io.flutter.plugin.common.MethodCall
import java.security.InvalidParameterException
import kotlin.properties.ReadOnlyProperty
import kotlin.properties.ReadWriteProperty
import kotlin.reflect.KProperty

// Deserialize Json objects

private interface JStruct {
    var map: Map<*, *>

    fun toJsonString() = jacksonObjectMapper().writeValueAsString(map)
}

internal class JSource(override var map: Map<*, *>) : JStruct {
    val sourceConfig by structGetter(::JSourceConfig).require()
}

internal class JSourceConfig(override var map: Map<*, *>) : JStruct {
    val url by GetString.require()
    val type by enumGetter<SourceType>()
    val title by GetString
    val description by GetString
    val audioCodecPriority by GetStringList
    val videoCodecPriority by GetStringList
    val isPosterPersistent by GetBool
    val posterSource by GetString
    val options by structGetter(::JSourceOptions)
    val drmConfig by structGetter(::JDrmConfig)
    val analyticsSourceMetadata by structGetter(::JSourceMetadata)
    val subtitleTracks by structListGetter(::JSubtitleTrack).require()
}

internal class JSourceMetadata(override var map: Map<*, *>) : JStruct {
    val title by GetString
    val videoId by GetString
    val cdnProvider by GetString
    val path by GetString
    val isLive by GetBool
    val customData by structGetter(::JCustomData)
}

internal class JSourceOptions(override var map: Map<*, *>) : JStruct {
    val startOffset by GetDouble
    val startOffsetTimelineReference by enumGetter<TimelineReferencePoint>()
}

internal class JDrmConfig(override var map: Map<*, *>) : JStruct {
    val widevine by structGetter(::JWidevineConfig)
}

internal class JWidevineConfig(override var map: Map<*, *>) : JStruct {
    val prepareMessage by GetBool
    val prepareLicense by GetBool
    val licenseUrl by GetString
    val preferredSecurityLevel by GetString
    val shouldKeepDrmSessionsAlive by GetBool
    val httpHeaders by GetStringMap
}

internal class JStyleConfig(override var map: Map<*, *>) : JStruct {
    val isUiEnabled by GetBool
    val isHideFirstFrame by GetBool
    val supplementalPlayerUiCss by GetString
    val scalingMode by enumGetter<ScalingMode>()
    val playerUiCss by GetString
    val playerUiJs by GetString
}

internal class JPlaybackConfig(override var map: Map<*, *>) : JStruct {
    val isAutoplayEnabled by GetBool
    val isMuted by GetBool
    val isTimeShiftEnabled by GetBool
    val isTunneledPlaybackEnabled by GetBool
    val audioCodecPriority by GetStringList
    val videoCodecPriority by GetStringList
    val audioFilter by enumGetter<MediaFilter>()
    val videoFilter by enumGetter<MediaFilter>()
    val seekMode by enumGetter<SeekMode>()
}

internal class JLicensingConfig(override var map: Map<*, *>) : JStruct {
    val delay by GetInt
}

internal class JLiveConfig(override var map: Map<*, *>) : JStruct {
    val minTimeShiftBufferDepth by GetDouble
    val liveEdgeOffset by GetDouble
}

internal class JAnalyticsConfig(override var map: Map<*, *>) : JStruct {
    val licenseKey by GetString.require()
    val adTrackingDisabled by GetBool
    val randomizeUserId by GetBool
    val retryPolicy by enumGetter { stringValue ->
        when (stringValue) {
            "NoRetry" -> RetryPolicy.NO_RETRY
            "ShortTerm" -> RetryPolicy.SHORT_TERM
            "LongTerm" -> RetryPolicy.LONG_TERM
            else -> throw InvalidParameterException("Unknown enum value $stringValue")
        }
    }
    val backendUrl by GetString
    val defaultMetadata by structGetter(::JDefaultMetadata)
}

internal class JDefaultMetadata(override var map: Map<*, *>) : JStruct {
    val cdnProvider by GetString
    val customUserId by GetString
    val customData by structGetter(::JCustomData)
}

internal class JCustomData(override var map: Map<*, *>) : JStruct {
    val customData1 by GetString
    val customData2 by GetString
    val customData3 by GetString
    val customData4 by GetString
    val customData5 by GetString
    val customData6 by GetString
    val customData7 by GetString
    val customData8 by GetString
    val customData9 by GetString
    val customData10 by GetString
    val customData11 by GetString
    val customData12 by GetString
    val customData13 by GetString
    val customData14 by GetString
    val customData15 by GetString
    val customData16 by GetString
    val customData17 by GetString
    val customData18 by GetString
    val customData19 by GetString
    val customData20 by GetString
    val customData21 by GetString
    val customData22 by GetString
    val customData23 by GetString
    val customData24 by GetString
    val customData25 by GetString
    val customData26 by GetString
    val customData27 by GetString
    val customData28 by GetString
    val customData29 by GetString
    val customData30 by GetString
    val experimentName by GetString
}

internal class JPlayerConfig(override var map: Map<*, *>) : JStruct {
    val key by GetString
    val styleConfig by structGetter(::JStyleConfig)
    val playbackConfig by structGetter(::JPlaybackConfig)
    val licensingConfig by structGetter(::JLicensingConfig)
    val liveConfig by structGetter(::JLiveConfig)
    val analyticsConfig by structGetter(::JAnalyticsConfig)
    val remoteControlConfig by structGetter(::JRemoteControlConfig)
}

internal class JRemoteControlConfig(override var map: Map<*, *>) : JStruct {
    val receiverStylesheetUrl by GetString
    val customReceiverConfig by GetStringMap
    val isCastEnabled by GetBool
    val sendManifestRequestsWithCredentials by GetBool
    val sendSegmentRequestsWithCredentials by GetBool
    val sendDrmLicenseRequestsWithCredentials by GetBool
}

internal class JSubtitleTrack(override var map: Map<*, *>) : JStruct {
    constructor(subtitleTrack: SubtitleTrack) : this(emptyMap<String, Any>()) {
        url = subtitleTrack.url
        id = subtitleTrack.id
        format = subtitleTrack.mimeType
        label = subtitleTrack.label ?: subtitleTrack.id
        isDefault = subtitleTrack.isDefault
        isForced = subtitleTrack.isForced
        language = subtitleTrack.language
    }

    var url by GetSetString
    var id by GetSetString.require()
    var format by GetSetString
    var label by GetSetString.require()
    var isDefault by GetSetBool.require()
    var isForced by GetSetBool.require()
    var language by GetSetString
}

// Methods

/** Arguments for all [Player] methods. */
@JvmInline
internal value class JMethodArgs(private val call: MethodCall) {
    val asCreatePlayerArgs get() = JCreatePlayerArgs(asMap)
    val asPlayerMethodArgs get() = JPlayerMethodArg(asMap)
    val asCastManagerOptions get() = JBitmovinCastManagerOptions(asMap)
    val asCastSendMessageArgs get() = JBitmovinCastManagerSendMessageArgs(asMap)
    private val asMap get() = call.arguments as Map<*, *>
}

/** Arguments for [BitmovinCastManager.initialize] */
internal class JBitmovinCastManagerOptions(override var map: Map<*, *>) : JStruct {
    val applicationId by GetString
    val messageNamespace by GetString
}

/** Arguments for [BitmovinCastManager.sendMessage] */
internal class JBitmovinCastManagerSendMessageArgs(override var map: Map<*, *>) : JStruct {
    val message by GetString
    val messageNamespace by GetString
}

/** Arguments for [Player.create]. */
internal class JCreatePlayerArgs(override var map: Map<*, *>) : JStruct {
    val id by GetString.require()
    val playerConfig by structGetter(::JPlayerConfig).require()
}

/** Argument for all [Player] instance methods. */
internal class JPlayerMethodArg(override var map: Map<*, *>) : JStruct {
    val asDouble get() = data as Double
    val asString get() = data as String
    val asOptionalString get() = data as String?
    val asSource get() = JSource(dataAsMap)
    val asSourceConfig get() = JSourceConfig(dataAsMap)
    val asCustomData get() = JCustomData(dataAsMap)
    private val data by GetAny
    private val dataAsMap get() = data as Map<*, *>
}

internal class JPlayerViewCreateArgs(override var map: Map<*, *>) : JStruct {
    val playerId by GetString.require()
    val hasFullscreenHandler by GetBool.require()
    val isFullscreen by GetBool.require()
}

// Private property delegator

private val GetAny = castGetter<Any>()
private val GetBool = castGetter<Boolean>()
private val GetSetBool = CastDelegate<Boolean>()
private val GetInt = castGetter<Int>()
private val GetDouble = castGetter<Double>()
private val GetString = castGetter<String>()
private val GetSetString = CastDelegate<String>()
private val GetStringList = listGetter<String>()
private val GetStringMap = mapGetter<String, String>()

/** Get a field from a JSON struct */
private fun interface Getter<T> : ReadOnlyProperty<JStruct, T>

private interface GetterSetter<T> : ReadWriteProperty<JStruct, T>

/** Get a field from it's name, cast it to [I] then convert it to [O] with [build]. */
private inline fun <reified I, O> getter(crossinline build: (I) -> O) =
    Getter { thisRef, kProp ->
        (thisRef.map[kProp.name] as I?)?.let(build)
    }

private open class JsonPropertyDelegate<I, O>(val build: (I) -> O) : GetterSetter<O?> {
    override fun getValue(
        thisRef: JStruct,
        property: KProperty<*>,
    ): O? = (thisRef.map[property.name] as I?)?.let(build)

    override fun setValue(
        thisRef: JStruct,
        property: KProperty<*>,
        value: O?,
    ) {
        thisRef.map = thisRef.map.toMutableMap().apply { set(property.name, value) }
    }
}

private class JsonPropertyDelegateRequired<I, O>(
    val inner: JsonPropertyDelegate<I, O>,
) : GetterSetter<O> {
    override fun getValue(
        thisRef: JStruct,
        property: KProperty<*>,
    ): O =
        inner.getValue(thisRef, property)
            ?: throw InvalidParameterException("Missing argument ${property.name}")

    override fun setValue(
        thisRef: JStruct,
        property: KProperty<*>,
        value: O,
    ) = inner.setValue(thisRef, property, value)
}

/** Getter decorator: throw if the field is not present. */
private fun <T> Getter<T?>.require() =
    Getter<T> { thisRef, property ->
        getValue(thisRef, property)
            ?: throw InvalidParameterException("Missing argument ${property.name}")
    }

private fun <I, O> JsonPropertyDelegate<I, O>.require() = JsonPropertyDelegateRequired(this)

private inline fun <reified T> listGetter() = getter { list: List<*> -> list.map { it as T } }

private inline fun <reified E : Enum<E>> enumGetter(crossinline enumValueOf: (String) -> E) = getter(enumValueOf)

private inline fun <reified E : Enum<E>> enumGetter() = getter { name: String -> enumValueOf<E>(name, ignoreCase = true) }

private inline fun <reified E : Enum<E>> enumValueOf(
    name: String,
    ignoreCase: Boolean,
): E {
    enumValues<E>().forEach {
        if (name.equals(it.name, ignoreCase)) return it
    }
    throw InvalidParameterException("Unknown enum value $name")
}

private inline fun <reified K, reified V> mapGetter() = getter { map: Map<*, *> -> map.map { it.key as K to it.value as V }.toMap() }

private inline fun <reified T> castGetter() = getter<T, T> { it }

private class CastDelegate<T> : JsonPropertyDelegate<T, T>({ it })

private inline fun <reified T : JStruct> structGetter(crossinline build: (Map<*, *>) -> T) = getter(build)

private inline fun <reified T : JStruct> structListGetter(crossinline build: (Map<*, *>) -> T) =
    getter { list: List<Map<*, *>> -> list.map { build(it) } }
