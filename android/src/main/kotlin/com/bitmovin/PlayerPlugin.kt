package com.bitmovin

import android.app.Activity
import com.bitmovin.player.PlayerMethod
import com.bitmovin.player.PlayerViewFactory

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.lang.ref.WeakReference

class PlayerPlugin: FlutterPlugin, ActivityAware, MethodCallHandler {
  private val tag: String = this::class.java.simpleName
  private var flutterPluginBindingReference = WeakReference<FlutterPlugin.FlutterPluginBinding>(null)

  private fun register(registrar: FlutterPlugin.FlutterPluginBinding, activity: Activity) {
    registrar
      .platformViewRegistry
      .registerViewFactory("player-view", PlayerViewFactory(registrar, activity))
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "CREATE_PLAYER" -> {
        val id = ((call.arguments as Map<*, *>)["id"]) as String
        val config = ((call.arguments as Map<*, *>)["playerConfig"]) as Map<*, *>?
        val playerConfig = Helper.buildPlayerConfig(config)
        val target = PlayerMethod(
          flutterPluginBindingReference.get()!!.applicationContext,
          id,
          flutterPluginBindingReference.get()!!.binaryMessenger,
          playerConfig
        )
        result.success(true)
//        MethodChannel(flutterPluginBindingReference.get()!!.binaryMessenger,"player-$id").apply {
//          this.setMethodCallHandler(target)
//        }
//        EventChannel(flutterPluginBindingReference.get()!!.binaryMessenger, "player-events-$id").apply {
//          this.setStreamHandler(target)
//        }
      }
    }
  }

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    flutterPluginBindingReference = WeakReference(flutterPluginBinding)
    ChannelManager.register(flutterPluginBinding, this@PlayerPlugin)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    flutterPluginBindingReference.clear()
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    register(flutterPluginBindingReference.get()!!, binding.activity)
  }

  override fun onDetachedFromActivityForConfigChanges() {}

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}

  override fun onDetachedFromActivity() {}
}
