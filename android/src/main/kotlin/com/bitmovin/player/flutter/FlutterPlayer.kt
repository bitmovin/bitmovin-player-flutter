package com.bitmovin.player.flutter

import android.content.Context
import com.bitmovin.analytics.api.AnalyticsConfig
import com.bitmovin.analytics.api.DefaultMetadata
import com.bitmovin.analytics.api.SourceMetadata
import com.bitmovin.player.api.Player
import com.bitmovin.player.api.PlayerConfig
import com.bitmovin.player.api.analytics.AnalyticsApi.Companion.analytics
import com.bitmovin.player.api.analytics.create
import com.bitmovin.player.api.drm.WidevineConfig
import com.bitmovin.player.api.source.Source
import com.bitmovin.player.flutter.drm.WidevineCallbacksHandler
import com.bitmovin.player.flutter.json.JMethodArgs
import com.bitmovin.player.flutter.json.JPlayerMethodArg
import com.bitmovin.player.flutter.json.JSourceConfig
import com.bitmovin.player.flutter.json.JSubtitleTrack
import com.bitmovin.player.flutter.json.JsonMethodHandler
import com.bitmovin.player.flutter.json.metadata
import com.bitmovin.player.flutter.json.toNative
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.StreamHandler

/**
 * Wraps a Bitmovin `Player` and is connected to a player instance that was created on the Flutter
 * side in Dart. Communication with the player instance on the Flutter side happens through the
 * method channel. Player events are communicated to the Flutter side through the event channel.
 */
class FlutterPlayer(
    context: Context,
    private val id: String,
    messenger: BinaryMessenger,
    config: PlayerConfig?,
    analyticsConfig: AnalyticsConfig?,
    defaultMetadata: DefaultMetadata?,
) : StreamHandler, EventListener() {
    private var widevineCallbacksHandler: WidevineCallbacksHandler? = null
    private val methodChannel = ChannelManager.registerMethodChannel(
        "${Channels.PLAYER}-$id",
        JsonMethodHandler(this::onMethodCall),
        messenger,
    )
    private val eventChannel = ChannelManager.registerEventChannel(
        "${Channels.PLAYER_EVENT}-$id",
        this@FlutterPlayer,
        messenger,
    )
    private val player: Player

    init {
        player = PlayerManager.create(id, context, config, analyticsConfig, defaultMetadata)
    }

    private fun Player.load(jSourceConfig: JSourceConfig) {
        val sourceConfig = jSourceConfig.toNative()
        val widevineConfig = sourceConfig.drmConfig as? WidevineConfig
        val widevineMetadata = jSourceConfig.drmConfig?.widevine?.metadata

        if (widevineConfig != null && widevineMetadata != null) {
            widevineCallbacksHandler = WidevineCallbacksHandler(
                widevineMetadata,
                widevineConfig,
                methodChannel,
            )
        }

        val sourceMetadata = jSourceConfig.analyticsSourceMetadata?.toNative() ?: SourceMetadata()
        load(Source.create(sourceConfig, sourceMetadata))
    }

    private fun Player.onMethodCall(method: String, arg: JPlayerMethodArg): Any = when (method) {
        Methods.LOAD_WITH_SOURCE_CONFIG -> load(arg.asSourceConfig)
        Methods.LOAD_WITH_SOURCE -> load(arg.asSource.sourceConfig)
        Methods.PLAY -> play()
        Methods.PAUSE -> pause()
        Methods.MUTE -> mute()
        Methods.UNMUTE -> unmute()
        Methods.SEEK -> seek(arg.asDouble)
        Methods.CURRENT_TIME -> currentTime
        Methods.DURATION -> duration
        Methods.GET_TIME_SHIFT -> timeShift
        Methods.SET_TIME_SHIFT -> timeShift(arg.asDouble)
        Methods.MAX_TIME_SHIFT -> maxTimeShift
        Methods.IS_LIVE -> isLive
        Methods.IS_PLAYING -> isPlaying
        Methods.SEND_CUSTOM_DATA_EVENT -> this.analytics?.sendCustomDataEvent(arg.asCustomData.toNative())
            ?: Unit
        Methods.DESTROY -> destroyPlayer()
        Methods.AVAILABLE_SUBTITLES -> availableSubtitles.map { JSubtitleTrack(it).toJsonString() }
        Methods.GET_SUBTITLE -> subtitle?.let { JSubtitleTrack(it).toJsonString() } ?: Unit
        // TODO: Can we make this nicer?
        Methods.SET_SUBTITLE -> setSubtitle(if (arg.hasData) arg.asString else null)
        Methods.REMOVE_SUBTITLE -> removeSubtitle(arg.asString)
        else -> throw NotImplementedError()
    }

    private fun destroyPlayer() {
        PlayerManager.destroy(id)
        methodChannel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)
    }

    private fun onMethodCall(method: String, arguments: JMethodArgs): Any {
        return player.onMethodCall(method, arguments.asPlayerMethodArgs)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sink = events
        listenToEvent(player)
    }

    override fun onCancel(arguments: Any?) {
        sink = null
    }
}
