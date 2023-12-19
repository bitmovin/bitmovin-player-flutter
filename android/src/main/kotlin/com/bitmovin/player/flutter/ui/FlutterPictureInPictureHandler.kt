package com.bitmovin.player.flutter.ui

import android.app.Activity
import com.bitmovin.player.api.Player
import com.bitmovin.player.ui.DefaultPictureInPictureHandler

class FlutterPictureInPictureHandler(
    activity: Activity,
    player: Player,
) : DefaultPictureInPictureHandler(activity, player) {
    // Track this state manually, since the lifecycle in Flutter is a bit different than using a
    // DefaultPictureInPictureHandler within the native app environment.
    // The difference being that we always want to emit PictureInPictureEnter and PictureInPictureExit events
    // so that they can bubble up to the flutter UI and customers can react to picture in picture state changes.
    // The mentioned events are only emitted if not already in the same `isPictureInPicture` state and if called
    // the PiP is exited via palyerView API.
    // TODO: Improve this comment
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
