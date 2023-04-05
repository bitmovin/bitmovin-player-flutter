// EventPayload.kt
// Created by Vijae Manlapaz
package com.bitmovin.core.data

data class EventPayload(val type: EventType, val currentTime: Double? = 0.0, val duration: Double? = 0.0)
