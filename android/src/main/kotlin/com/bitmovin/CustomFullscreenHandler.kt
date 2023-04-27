package com.bitmovin

import android.app.Activity
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.view.View
import android.view.ViewGroup
import com.bitmovin.core.Channel
import com.bitmovin.player.PlayerView
import com.bitmovin.player.api.ui.FullscreenHandler
import com.bitmovin.player.ui.getSystemUiVisibilityFlags
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel

class CustomFullscreenHandler(
    activity: Activity,
    private val playerView: PlayerView,
    private val sink: EventChannel.EventSink?
) : FullscreenHandler {
    private val tag: String = this::class.java.simpleName
    override var isFullscreen = false
    private var decorView: View? = activity.window.decorView
    private val playerOrientationListener = PlayerOrientationListener(activity).apply { enable() }

    private fun handleFullscreen(fullscreen: Boolean) {
        Log.e(tag, "==== handleFullscreen ====")
        sink?.success(fullscreen)
        isFullscreen = fullscreen
        doSystemUiVisibility(fullscreen)
        doLayoutChanges()
    }

    private fun doSystemUiVisibility(fullScreen: Boolean) {
        decorView?.post {
            val uiParams = getSystemUiVisibilityFlags(fullScreen, true)
            decorView?.systemUiVisibility = uiParams
        }
    }

    private fun doLayoutChanges() {
        val mainLooper = Looper.getMainLooper()
        val isAlreadyMainLooper = Looper.myLooper() == mainLooper

        if (isAlreadyMainLooper) {
            updateLayout()
        } else {
            val handler = Handler(mainLooper)
            handler.post(::updateLayout)
        }
    }

    private fun updateLayout() {
        val parentView = playerView.parent
//        toolbar?.visibility = if (isFullscreen) View.GONE else View.VISIBLE

        if (parentView !is ViewGroup) return

        for (i in 0 until parentView.childCount) {
            parentView
                .getChildAt(i)
                .takeIf { it !== playerView }
                ?.visibility = if (this.isFullscreen) View.GONE else View.VISIBLE
        }
    }

    override fun onFullscreenRequested() = handleFullscreen(true)

    override fun onFullscreenExitRequested() = handleFullscreen(false)

    override fun onResume() {
        if (isFullscreen) {
            doSystemUiVisibility(isFullscreen)
        }
    }

    override fun onPause() {}

    override fun onDestroy() = playerOrientationListener.disable()
}