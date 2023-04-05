// PlayerNativeViewFactory.kt
// Created by Vijae Manlapaz
package com.bitmovin.ui

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class PlayerNativeViewFactory(private val messenger: BinaryMessenger) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    @Suppress("unused")
    private val tag: String = PlayerNativeViewFactory::class.java.simpleName

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String, Any>?
        return PlayerNativeView(context, creationParams, messenger, viewId)
    }
}