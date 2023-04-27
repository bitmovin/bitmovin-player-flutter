package com.bitmovin

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

class ChannelManager {
    companion object {
        fun register(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding, handler: MethodCallHandler) {
            MethodChannel(flutterPluginBinding.binaryMessenger, "channel-manager").apply {
                this.setMethodCallHandler(handler)
            }
        }
    }
}