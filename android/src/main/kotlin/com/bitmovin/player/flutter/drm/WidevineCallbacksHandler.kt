package com.bitmovin.player.flutter.drm

import android.util.Base64
import androidx.concurrent.futures.CallbackToFutureAdapter
import com.bitmovin.player.api.drm.PrepareLicenseCallback
import com.bitmovin.player.api.drm.PrepareMessageCallback
import com.bitmovin.player.api.drm.WidevineConfig
import com.bitmovin.player.flutter.Methods
import com.bitmovin.player.flutter.runOnMainThread
import io.flutter.plugin.common.MethodChannel

class WidevineCallbacksHandler(
    private val metadata: WidevineConfigMetadata,
    private val widevineConfig: WidevineConfig,
    private val methodChannel: MethodChannel,
) {
    init {
        assignHandlers()
    }

    private fun assignHandlers() {
        if (metadata.hasPrepareMessage) {
            widevineConfig.prepareMessageCallback =
                PrepareMessageCallback { keyMessage ->
                    handleCallback(
                        Methods.WIDEVINE_PREPARE_MESSAGE,
                        mapOf(
                            "keyMessage" to Base64.encodeToString(keyMessage, Base64.NO_WRAP),
                        ),
                    )
                }
        }

        if (metadata.hasPrepareLicense) {
            widevineConfig.prepareLicenseCallback =
                PrepareLicenseCallback { licenseResponse ->
                    handleCallback(
                        Methods.WIDEVINE_PREPARE_LICENSE,
                        mapOf(
                            "licenseResponse" to Base64.encodeToString(licenseResponse, Base64.NO_WRAP),
                        ),
                    )
                }
        }
    }

    private fun handleCallback(
        methodName: String,
        arguments: Map<String, Any>,
    ): ByteArray {
        return CallbackToFutureAdapter
            .getFuture { completer ->
                runOnMainThread {
                    methodChannel.invokeMethod(
                        methodName,
                        arguments,
                        object : MethodChannel.Result {
                            override fun success(result: Any?) {
                                if (result !is String) {
                                    completer.setException(
                                        Exception("Invalid result type found for: $methodName"),
                                    )
                                    return
                                }

                                completer.set(Base64.decode(result, Base64.NO_WRAP))
                            }

                            override fun error(
                                errorCode: String,
                                errorMessage: String?,
                                errorDetails: Any?,
                            ) {
                                completer.setException(
                                    Exception("Error when calling $methodName. Error code: $errorCode, message: $errorMessage"),
                                )
                            }

                            override fun notImplemented() {
                                completer.setException(
                                    Exception("Method not implemented: $methodName"),
                                )
                            }
                        },
                    )
                }
            }.get()
    }
}
