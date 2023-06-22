package com.bitmovin.player.drm

import android.util.Base64
import com.bitmovin.core.data.Methods
import com.bitmovin.core.runOnMainThread
import com.bitmovin.player.api.drm.PrepareLicenseCallback
import com.bitmovin.player.api.drm.PrepareMessageCallback
import com.bitmovin.player.api.drm.WidevineConfig
import io.flutter.plugin.common.MethodChannel
import java.util.concurrent.locks.ReentrantLock
import kotlin.concurrent.withLock

class WidevineCallbacksHandler(
    private val metadata: WidevineConfigMetadata,
    private val widevineConfig: WidevineConfig,
    private val methodChannel: MethodChannel,
) {
    private val lock = ReentrantLock()
    private val prepareMessageCondition = lock.newCondition()
    private val prepareLicenseCondition = lock.newCondition()

    init {
        assignHandlers()
    }

    private fun assignHandlers() {
        if (metadata.hasPrepareMessage) {
            widevineConfig.prepareMessageCallback = PrepareMessageCallback { keyMessage ->
                handlePrepareMessage(keyMessage)
            }
        }

        if (metadata.hasPrepareLicense) {
            widevineConfig.prepareLicenseCallback = PrepareLicenseCallback { licenseResponse ->
                handlePrepareLicense(licenseResponse)
            }
        }
    }

    private fun handlePrepareMessage(keyMessage: ByteArray): ByteArray {
        var prepareMessageResult = keyMessage

        lock.withLock {
            runOnMainThread {
                methodChannel.invokeMethod(
                    Methods.WIDEVINE_PREPARE_MESSAGE,
                    mapOf(
                        "keyMessage" to Base64.encodeToString(keyMessage, Base64.NO_WRAP),
                    ),
                    object : MethodChannel.Result {
                        override fun success(result: Any?) {
                            if (result !is String) { return }

                            lock.withLock {
                                prepareMessageResult = Base64.decode(result, Base64.NO_WRAP)
                                prepareMessageCondition.signal()
                            }
                        }

                        override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                            lock.withLock {
                                prepareMessageCondition.signal()
                            }
                        }

                        override fun notImplemented() {
                            lock.withLock {
                                prepareMessageCondition.signal()
                            }
                        }
                    },
                )
            }

            prepareMessageCondition.await()
        }

        return prepareMessageResult
    }

    private fun handlePrepareLicense(licenseResponse: ByteArray): ByteArray {
        var prepareLicenseResult = licenseResponse

        lock.withLock {
            runOnMainThread {
                methodChannel.invokeMethod(
                    Methods.WIDEVINE_PREPARE_LICENSE,
                    mapOf(
                        "licenseResponse" to Base64.encodeToString(licenseResponse, Base64.NO_WRAP),
                    ),
                    object : MethodChannel.Result {
                        override fun success(result: Any?) {
                            if (result !is String) { return }

                            lock.withLock {
                                prepareLicenseResult = Base64.decode(result, Base64.NO_WRAP)
                                prepareLicenseCondition.signal()
                            }
                        }

                        override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                            lock.withLock {
                                prepareLicenseCondition.signal()
                            }
                        }

                        override fun notImplemented() {
                            lock.withLock {
                                prepareLicenseCondition.signal()
                            }
                        }
                    },
                )
            }

            prepareLicenseCondition.await()
        }

        return prepareLicenseResult
    }
}
