package com.bitmovin.player.flutter

class Methods {
    companion object {
        // Player related methods
        const val CREATE_PLAYER = "createPlayer"
        const val LOAD_WITH_SOURCE_CONFIG = "loadWithSourceConfig"
        const val LOAD_WITH_SOURCE = "loadWithSource"
        const val PLAY = "play"
        const val PAUSE = "pause"
        const val MUTE = "mute"
        const val UNMUTE = "unmute"
        const val SEEK = "seek"
        const val CURRENT_TIME = "currentTime"
        const val DURATION = "duration"
        const val DESTROY = "destroy"
        const val SET_TIME_SHIFT = "setTimeShift"
        const val GET_TIME_SHIFT = "getTimeShift"
        const val MAX_TIME_SHIFT = "maxTimeShift"
        const val IS_LIVE = "isLive"

        // Widevine DRM related methods
        const val WIDEVINE_PREPARE_MESSAGE = "widevinePrepareMessage"
        const val WIDEVINE_PREPARE_LICENSE = "widevinePrepareLicense"
    }
}
