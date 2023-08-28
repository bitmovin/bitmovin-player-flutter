package com.bitmovin.player.flutter

import com.bitmovin.player.api.ui.FullscreenHandler
import io.flutter.plugin.common.MethodChannel

class FullscreenHandlerProxy(
    override var isFullscreen: Boolean,
    private val methodChannel: MethodChannel,
) : FullscreenHandler {
    override fun onDestroy() {
        // no-op
    }

    override fun onFullscreenExitRequested() {
        isFullscreen = false
        runOnMainThread {
            methodChannel.invokeMethod(Methods.EXIT_FULLSCREEN, null)
        }
    }

    override fun onFullscreenRequested() {
        isFullscreen = true
        runOnMainThread {
            methodChannel.invokeMethod(Methods.ENTER_FULLSCREEN, null)
        }
    }

    override fun onPause() {
        // no-op
    }

    override fun onResume() {
        // no-op
    }
}
