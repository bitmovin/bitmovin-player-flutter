package com.bitmovin.player.flutter.ui

import android.app.Activity
import com.bitmovin.player.api.Player
import com.bitmovin.player.ui.DefaultPictureInPictureHandler

class FlutterPictureInPictureHandler(
    activity: Activity,
    player: Player,
) : DefaultPictureInPictureHandler(activity, player) {
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
