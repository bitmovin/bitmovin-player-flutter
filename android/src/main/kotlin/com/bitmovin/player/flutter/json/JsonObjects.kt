package com.bitmovin.player.flutter.json

import com.bitmovin.player.api.Player
import com.bitmovin.player.api.SeekMode
import com.bitmovin.player.api.media.MediaFilter
import com.bitmovin.player.api.source.SourceType
import com.bitmovin.player.api.source.TimelineReferencePoint
import com.bitmovin.player.api.ui.ScalingMode
import io.flutter.plugin.common.MethodCall
import java.security.InvalidParameterException
import kotlin.properties.ReadOnlyProperty

// Deserialize Json objects

private interface JStruct {
    val map: Map<*, *>
}

internal class JSource(override val map: Map<*, *>) : JStruct {
    val sourceConfig by structGetter(::JSourceConfig).require()
}

internal class JSourceConfig(override val map: Map<*, *>) : JStruct {
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
}

internal class JSourceOptions(override val map: Map<*, *>) : JStruct {
    val startOffset by GetDouble
    val startOffsetTimelineReference by enumGetter<TimelineReferencePoint>()
}

internal class JDrmConfig(override val map: Map<*, *>) : JStruct {
    val widevine by structGetter(::JWidevineConfig)
}

internal class JWidevineConfig(override val map: Map<*, *>) : JStruct {
    val prepareMessage by GetBool
    val prepareLicense by GetBool
    val licenseUrl by GetString
    val preferredSecurityLevel by GetString
    val shouldKeepDrmSessionsAlive by GetBool
    val httpHeaders by GetStringMap
}

internal class JStyleConfig(override val map: Map<*, *>) : JStruct {
    val isUiEnabled by GetBool
    val isHideFirstFrame by GetBool
    val supplementalPlayerUiCss by GetString
    val scalingMode by enumGetter<ScalingMode>()
    val playerUiCss by GetString
    val playerUiJs by GetString
}

internal class JPlaybackConfig(override val map: Map<*, *>) : JStruct {
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

internal class JLicensingConfig(override val map: Map<*, *>) : JStruct {
    val delay by GetInt
}

internal class JLiveConfig(override val map: Map<*, *>) : JStruct {
    val minTimeShiftBufferDepth by GetDouble
    val liveEdgeOffset by GetDouble
}

internal class JPlayerConfig(override val map: Map<*, *>) : JStruct {
    val key by GetString
    val styleConfig by structGetter(::JStyleConfig)
    val playbackConfig by structGetter(::JPlaybackConfig)
    val licensingConfig by structGetter(::JLicensingConfig)
    val liveConfig by structGetter(::JLiveConfig)
}

// Methods

/** Arguments for all [Player] methods. */
@JvmInline
internal value class JMethodArgs(private val call: MethodCall) {
    val asCreatePlayerArgs get() = JCreatePlayerArgs(asMap)
    val asPlayerMethodArgs get() = JPlayerMethodArg(asMap)
    private val asMap get() = call.arguments as Map<*, *>
}

/** Arguments for [Player.create]. */
internal class JCreatePlayerArgs(override val map: Map<*, *>) : JStruct {
    val id by GetString.require()
    val playerConfig by structGetter(::JPlayerConfig).require()
}

/** Argument for all [Player] instance methods. */
internal class JPlayerMethodArg(override val map: Map<*, *>) : JStruct {
    val asDouble get() = data as Double
    val asSource get() = JSource(dataAsMap)
    val asSourceConfig get() = JSourceConfig(dataAsMap)
    private val data by GetAny.require()
    private val dataAsMap get() = data as Map<*, *>
}

// Private property delegator

private val GetAny = castGetter<Any>()
private val GetBool = castGetter<Boolean>()
private val GetInt = castGetter<Int>()
private val GetDouble = castGetter<Double>()
private val GetString = castGetter<String>()
private val GetStringList = listGetter<String>()
private val GetStringMap = mapGetter<String, String>()

/** Get a field from a JSON struct */
private fun interface Getter<T> : ReadOnlyProperty<JStruct, T>

/** Get a field from it's name, cast it to [I] then convert it to [O] with [build]. */
private inline fun <reified I, O> getter(crossinline build: (I) -> O) = Getter { thisRef, kProp ->
    (thisRef.map[kProp.name] as I?)?.let(build)
}

/** Getter decorator: throw if the field is not present. */
private fun <T> Getter<T?>.require() = Getter<T> { thisRef, property ->
    getValue(thisRef, property)
        ?: throw InvalidParameterException("Missing argument ${property.name}")
}

private inline fun <reified T> listGetter() = getter { list: List<*> -> list.map { it as T } }

private inline fun <reified E : Enum<E>> enumGetter() =
    getter { name: String -> enumValueOf<E>(name, ignoreCase = true) }

private inline fun <reified E : Enum<E>> enumValueOf(name: String, ignoreCase: Boolean): E {
    enumValues<E>().forEach {
        if (name.equals(it.name, ignoreCase)) return it
    }
    throw InvalidParameterException("Unknown enum value $name")
}

private inline fun <reified K, reified V> mapGetter() =
    getter { map: Map<*, *> -> map.map { it.key as K to it.value as V }.toMap() }

private inline fun <reified T> castGetter() = getter<T, T> { it }
private inline fun <reified T : JStruct> structGetter(crossinline build: (Map<*, *>) -> T) =
    getter(build)
