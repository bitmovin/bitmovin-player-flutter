package com.bitmovin

import com.bitmovin.core.Channel
import com.bitmovin.ui.PlayerNativeViewFactory
import io.flutter.embedding.engine.plugins.FlutterPlugin

/** PlayerPlugin */
class PlayerPlugin: FlutterPlugin {
  private val tag: String = this::class.java.simpleName

  private fun register(registrar: FlutterPlugin.FlutterPluginBinding) {
    registrar
      .platformViewRegistry
      .registerViewFactory(Channel.TYPE, PlayerNativeViewFactory(registrar.binaryMessenger))
  }

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    register(flutterPluginBinding)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) { }
}
