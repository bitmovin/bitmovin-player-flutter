package com.bitmovin.player.flutter.ui

import android.app.Activity
import android.app.PictureInPictureParams
import android.util.Log
import android.util.Rational
import com.bitmovin.player.api.Player
import com.bitmovin.player.ui.DefaultPictureInPictureHandler

private val TAG = "FlutterPictureInPictureHandler"

class FlutterPictureInPictureHandler(
    private val activity: Activity,
    private val player: Player,
) : DefaultPictureInPictureHandler(activity, player) {
    // Current PiP implementation on the native side requires playerView.exitPictureInPicture() to be called
    // for `PictureInPictureExit` event to be emitted.
    // Additonally the event is only emitted if `isPictureInPicture` is true. At the point in time we call
    // playerView.exitPictureInPicture() the activity will already have exited the PiP mode,
    // and thus the event won't be emitted. To work arround this we keep track of the PiP state ourselves.
    private var _isPictureInPicture = false

    override val isPictureInPicture: Boolean
        get() = _isPictureInPicture

    override fun enterPictureInPicture() {
        if (!isPictureInPictureAvailable) {
            Log.w(TAG, "Calling enterPictureInPicture without PiP support.")
            return
        }

        if (isPictureInPicture) {
            return
        }

        // The default implementation doesn't properly handle the case where source isn't loaded yet.
        // To work around it we just use a 16:9 aspect ratio if we cannot calculate it from `playbackVideoData`.
        val aspectRatio =
            player.playbackVideoData
                ?.let { Rational(it.width, it.height) }
                ?: Rational(16, 9)

        val params =
            PictureInPictureParams
                .Builder()
                .setAspectRatio(aspectRatio)
                .build()

        activity.enterPictureInPictureMode(params)
        _isPictureInPicture = true
    }

    override fun exitPictureInPicture() {
        super.exitPictureInPicture()
        _isPictureInPicture = false
    }
}
