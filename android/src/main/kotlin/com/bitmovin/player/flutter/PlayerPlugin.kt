package com.bitmovin.player.flutter

import android.app.Activity
import com.bitmovin.player.casting.BitmovinCastManager
import com.bitmovin.player.flutter.json.JBitmovinCastManagerOptions
import com.bitmovin.player.flutter.json.JBitmovinCastManagerSendMessageArgs
import com.bitmovin.player.flutter.json.JCreatePlayerArgs
import com.bitmovin.player.flutter.json.JMethodArgs
import com.bitmovin.player.flutter.json.JsonMethodHandler
import com.bitmovin.player.flutter.json.toNative
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import java.lang.ref.WeakReference

class PlayerPlugin : FlutterPlugin, ActivityAware {
    private var flutterPluginBindingReference = WeakReference<FlutterPlugin.FlutterPluginBinding>(null)
    private var activity = WeakReference<Activity?>(null)

    private fun register(registrar: FlutterPlugin.FlutterPluginBinding) {
        registrar
            .platformViewRegistry
            .registerViewFactory(Channels.PLAYER_VIEW, FlutterPlayerViewFactory(registrar.binaryMessenger))
    }

    private fun onMethodCall(
        method: String,
        arguments: JMethodArgs,
    ): Any =
        when (method) {
            Methods.CREATE_PLAYER -> createPlayer(arguments.asCreatePlayerArgs) != null
            Methods.CAST_MANAGER_INITIALIZE -> initializeCastManager(arguments.asCastManagerOptions)
            Methods.CAST_MANAGER_UPDATE_CONTEXT -> castManagerUpdateContext()
            Methods.CAST_MANAGER_SEND_MESSAGE -> sendCastMessage(arguments.asCastSendMessageArgs)
            else -> throw NotImplementedError()
        }

    private fun createPlayer(args: JCreatePlayerArgs) =
        flutterPluginBindingReference.get()?.let {
            val flutterPlayerConfig = args.playerConfig
            val config = flutterPlayerConfig.toNative()
            val analyticsConfig = flutterPlayerConfig.analyticsConfig?.toNative()
            val defaultMetadata = flutterPlayerConfig.analyticsConfig?.defaultMetadata?.toNative()
            FlutterPlayer(
                context = it.applicationContext,
                id = args.id,
                messenger = it.binaryMessenger,
                config = config,
                analyticsConfig = analyticsConfig,
                defaultMetadata = defaultMetadata,
            )
        }

    private fun initializeCastManager(options: JBitmovinCastManagerOptions) {
        val wasInitialized = BitmovinCastManager.isInitialized()
        BitmovinCastManager.initialize(options.applicationId, options.messageNamespace)
        if (!wasInitialized) castManagerUpdateContext()
    }

    private fun castManagerUpdateContext() {
        activity.get()?.let {
            BitmovinCastManager.getInstance().updateContext(it)
        }
    }

    private fun sendCastMessage(options: JBitmovinCastManagerSendMessageArgs) {
        BitmovinCastManager.getInstance().sendMessage(options.message, options.messageNamespace)
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        flutterPluginBindingReference = WeakReference(flutterPluginBinding)
        val handler = JsonMethodHandler(this::onMethodCall)
        ChannelManager.registerMethodChannel(Channels.MAIN, handler, flutterPluginBinding)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        flutterPluginBindingReference.clear()
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = WeakReference(binding.activity)
        flutterPluginBindingReference.get()?.let {
            register(it)
        }
        if (BitmovinCastManager.isInitialized()) {
            castManagerUpdateContext()
        }
    }

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}

    override fun onDetachedFromActivity() {
        activity = WeakReference(null)
    }
}
