package com.bitmovin.player.flutter

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

class ChannelManager {
    companion object {
        fun register(
            binding: FlutterPlugin.FlutterPluginBinding,
            handler: MethodCallHandler,
        ) {
            MethodChannel(binding.binaryMessenger, "channel-manager").apply {
                this.setMethodCallHandler(handler)
            }
        }

        fun registerMethodChannel(
            name: String,
            handler: MethodCallHandler,
            binding: FlutterPlugin.FlutterPluginBinding,
        ) {
            MethodChannel(binding.binaryMessenger, name).apply {
                this.setMethodCallHandler(handler)
            }
        }

        fun registerMethodChannel(
            name: String,
            handler: MethodCallHandler,
            binaryMessenger: BinaryMessenger,
        ): MethodChannel {
            return MethodChannel(binaryMessenger, name).apply {
                this.setMethodCallHandler(handler)
            }
        }

        fun registerEventChannel(
            name: String,
            handler: StreamHandler,
            binaryMessenger: BinaryMessenger,
        ): EventChannel {
            return EventChannel(binaryMessenger, name).apply {
                this.setStreamHandler(handler)
            }
        }
    }
}
