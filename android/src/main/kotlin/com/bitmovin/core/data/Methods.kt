package com.bitmovin.core.data

class Methods {
    companion object {
        const val CREATE_PLAYER = "create-player"
        const val CREATE_PLAYER_VIEW = "create-player-view"
        const val BIND_PLAYER = "bind-player"
        const val UNBIND_PLAYER = "unbind-player"

        // For player only
        const val LOAD_WITH_SOURCE_CONFIG = "loadWithSourceConfig"
        const val LOAD_WITH_SOURCE = "loadWithSource"
        const val PLAY = "play"
        const val PAUSE = "pause"
        const val MUTE = "mute"
        const val UNMUTE = "unmute"
        const val SEEK = "seek"
        const val CURRENT_TIME = "current_time"
        const val DURATION = "duration"
        const val DESTROY = "destroy"
    }
}
