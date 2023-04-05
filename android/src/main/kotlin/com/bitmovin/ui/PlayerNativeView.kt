package com.bitmovin.ui

import android.content.Context
import android.view.View
import com.bitmovin.player.PlayerView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView

class PlayerNativeView(
    context: Context?,
    creationParams: Map<String, Any>?,
    messenger: BinaryMessenger,
    viewId: Int,
) : PlatformView {
    private var playerUI: PlayerView

    init {
        if (context == null) throw Exception("Context is null")
        if (creationParams == null) throw Exception("No parameters defined")

        this.playerUI = PlayerView(
            context,
            PlayerNative(
             context = context,
             creationParams = creationParams,
             messenger = messenger,
             viewId = viewId
            ).player
        )
    }

    override fun getView(): View {
        return playerUI
    }

    override fun dispose() {
        playerUI.onDestroy()
    }

}