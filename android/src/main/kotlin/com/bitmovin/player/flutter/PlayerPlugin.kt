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
    private val tag: String = this::class.java.simpleName
    private var flutterPluginBindingReference =
        WeakReference<FlutterPlugin.FlutterPluginBinding>(null)

    private fun register(registrar: FlutterPlugin.FlutterPluginBinding) = registrar
        .platformViewRegistry
        .registerViewFactory(Channels.PLAYER_VIEW, PlayerViewFactory(registrar))


    private fun onMethodCall(method: String, arguments: JMethodArgs): Any = when (method) {
        Methods.CREATE_PLAYER -> createPlayer(arguments.asCreatePlayerArgs) != null
        else -> throw NotImplementedError()
    }

    private fun createPlayer(args: JCreatePlayerArgs) = flutterPluginBindingReference.get()?.let {
        val id = args.id ?: return@let false
        val config = args.playerConfig.toNative()
        PlayerMethod(it.applicationContext, id, it.binaryMessenger, config)
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        flutterPluginBindingReference = WeakReference(flutterPluginBinding)
        ChannelManager.registerMethodChannel(
            Channels.MAIN, JsonMethodHandler(this::onMethodCall), flutterPluginBinding
        )
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

