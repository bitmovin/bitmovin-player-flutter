// EventType.kt
// Created by Vijae Manlapaz
package com.bitmovin.core.data

enum class EventType(val printableName: String) {
    PLAY("play"),
    PAUSE("pause"),
    READY("ready"),
    DESTROY("destroy"),
    ACTIVE("active"),
    TIME_CHANGED("time_changed"),
    PLAYING("playing"),
    PLAYBACK_FINISHED("playback_finished"),
    LOAD("load"),
    LOADED("loaded"),
    SEEKED("seeked"),
    SEEK("seek"),
    WARNING("warning"),
    ERROR("error"),
    SOURCE_ERROR("source_error"),
    NETWORK_ERROR("network_error"),
    BUFFERRING_STARTED("buffering_started"),
    BUFFERRING_ENDED("buffering_ended"),
    RENDERED_FIRST_FRAME("rendered_first_frame"),
}
