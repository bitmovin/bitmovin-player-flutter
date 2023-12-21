package com.bitmovin.player.flutter.ui

import android.app.Activity
import com.bitmovin.player.api.Player
import com.bitmovin.player.ui.DefaultPictureInPictureHandler

class FlutterPictureInPictureHandler(
    activity: Activity,
    player: Player,
) : DefaultPictureInPictureHandler(activity, player) {
    // Current PiP implementation on the native side requires playerView.exitPictureInPicture() to be called
    // in order for PictureInPictureExit event to be emitted.
    // Additonally the event is only emitted if isPictureInPicture is false. At the point in time we call
    // playerView.exitPictureInPicture() the activity will already be in PiP mode, and thus the event won't be emitted.
    // To work arround this we keep track of the PiP state ourselves.
    private var _isPictureInPicture = false

    override val isPictureInPicture: Boolean
        get() = _isPictureInPicture

    override fun enterPictureInPicture() {
        super.enterPictureInPicture()
        _isPictureInPicture = true
    }

    override fun exitPictureInPicture() {
        super.exitPictureInPicture()
        _isPictureInPicture = false
    }
}
