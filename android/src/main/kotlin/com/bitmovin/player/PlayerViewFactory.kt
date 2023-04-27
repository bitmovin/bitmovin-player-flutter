package com.bitmovin.player

import android.app.Activity
import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class PlayerViewFactory(
    private val registrar: FlutterPlugin.FlutterPluginBinding,
    private val activity: Activity
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    @Suppress("unused")
    private val tag: String = PlayerViewFactory::class.java.simpleName

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        return PlayerViewMethod(context!!, args, registrar.binaryMessenger, viewId)
    }
}