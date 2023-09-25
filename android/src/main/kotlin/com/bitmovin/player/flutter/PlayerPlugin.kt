package com.bitmovin.player.flutter

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

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        flutterPluginBindingReference = WeakReference(flutterPluginBinding)
        val handler = JsonMethodHandler(this::onMethodCall)
        ChannelManager.registerMethodChannel(Channels.MAIN, handler, flutterPluginBinding)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        flutterPluginBindingReference.clear()
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        flutterPluginBindingReference.get()?.let {
            register(it)
        }
    }

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}

    override fun onDetachedFromActivity() {}
}
