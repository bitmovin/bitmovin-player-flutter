package com.bitmovin.player.flutter

import android.app.Activity
import android.content.Context
import android.content.ContextWrapper
import android.os.Handler
import android.os.Looper

/**
 * Makes sure that the given block is executed on the main thread.
 * Only posts the block to the main thread if it is not already on the main thread.
 */
inline fun runOnMainThread(crossinline block: () -> Unit?) {
    if (Looper.myLooper() == Looper.getMainLooper()) {
        block()
    } else {
        Handler(Looper.getMainLooper()).post {
            block()
        }
    }
}

/**
 * Posts the given block to the main thread, even if the current thread is already the main thread.
 */
inline fun postToMainThread(crossinline block: () -> Unit?) {
    Handler(Looper.getMainLooper()).post {
        block()
    }
}

fun Context.requireActivity(): Activity =
    when (this) {
        is Activity -> this
        is ContextWrapper -> baseContext.requireActivity()
        else -> error("No activity found for context $this")
    }
