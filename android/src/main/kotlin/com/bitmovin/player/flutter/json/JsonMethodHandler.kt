package com.bitmovin.player.flutter.json

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/** set Result from returned object or set an error if an exception is thrown. */
internal class JsonMethodHandler(
    private val handler: (String, JMethodArgs) -> Any,
) : MethodChannel.MethodCallHandler {
    override fun onMethodCall(
        call: MethodCall,
        result: MethodChannel.Result,
    ) {
        try {
            val successResult = handler(call.method, JMethodArgs(call))
            // Flutter requires returning null if there are no results.
            result.success(if (successResult is Unit) null else successResult)
        } catch (_: NotImplementedError) {
            result.notImplemented()
        } catch (e: Exception) {
            result.error("Method ${call.method} failed", e.message, null)
        }
    }
}
