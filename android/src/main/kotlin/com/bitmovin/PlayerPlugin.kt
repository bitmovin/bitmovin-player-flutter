package com.bitmovin

import com.bitmovin.core.Channels
import com.bitmovin.core.data.Methods
import com.bitmovin.player.PlayerMethod
import com.bitmovin.player.PlayerViewFactory
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.lang.ref.WeakReference

class PlayerPlugin : FlutterPlugin, ActivityAware, MethodCallHandler {
    private val tag: String = this::class.java.simpleName
    private var flutterPluginBindingReference = WeakReference<FlutterPlugin.FlutterPluginBinding>(null)

    private fun register(registrar: FlutterPlugin.FlutterPluginBinding) {
        registrar
            .platformViewRegistry
            .registerViewFactory(Channels.PLAYER_VIEW, PlayerViewFactory(registrar))
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            Methods.CREATE_PLAYER -> {
                val id = ((call.arguments as Map<*, *>)["id"]) as String
                val config = ((call.arguments as Map<*, *>)["playerConfig"]) as Map<*, *>?
                val playerConfig = Helper.buildPlayerConfig(config)
                flutterPluginBindingReference.get()?.let {
                    PlayerMethod(
                        it.applicationContext,
                        id,
                        it.binaryMessenger,
                        playerConfig,
                    )
                    result.success(true)
                    return
                }
                result.success(false)
            }
        }
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        flutterPluginBindingReference = WeakReference(flutterPluginBinding)
        ChannelManager.registerMethodChannel(Channels.MAIN, this@PlayerPlugin, flutterPluginBinding)
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
