package com.bitmovin.core

import android.os.Handler
import android.os.Looper

fun runOnMainThread(block: () -> Unit?) {
    if (Looper.myLooper() == Looper.getMainLooper()) {
        block()
    } else {
        Handler(Looper.getMainLooper()).post {
            block()
        }
    }
}
