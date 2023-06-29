package com.bitmovin.player.flutter.json

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

internal class JsonMethodHandler(private val handler: (String, JMethodArgs) -> Any) :
    MethodChannel.MethodCallHandler {
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        try {
            result.success(handler(call.method, JMethodArgs(call)))
        } catch (_: NotImplementedError) {
            result.notImplemented()
        } catch (e: Exception) {
            result.error("Method ${call.method} failed", e.message, null)
        }
    }
}
