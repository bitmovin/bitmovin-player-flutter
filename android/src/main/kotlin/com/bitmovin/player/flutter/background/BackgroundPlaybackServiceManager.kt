package com.bitmovin.player.flutter.background

import android.app.Service
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.ServiceConnection
import android.os.IBinder

/**
 * Entry point to define a custom background playback service, if the default service does not fit your needs.
 * The service you define here must also be registered in your AndroidManifest.xml.
 */
object BackgroundPlaybackServiceManager {
    private var serviceClass: Class<out Service> = BackgroundPlaybackService::class.java
    private var connection: ServiceConnection = DefaultServiceConnection()

    /**
     * Sets the service class that should be used for background playback.
     * It's recommended to set this only once in your app, e.g. in your Application's onCreate.
     */
    @JvmStatic
    fun setServiceClass(serviceClass: Class<out Service>) {
        this.serviceClass = serviceClass
    }

    @JvmStatic
    fun startBindingService(context: Context) {
        val intent = Intent(context, serviceClass)
        context.bindService(intent, connection, Context.BIND_AUTO_CREATE)
        context.startService(intent)
    }

    @JvmStatic
    fun stopService(context: Context) {
        context.unbindService(connection)
        context.stopService(Intent(context, serviceClass))
    }
}

class DefaultServiceConnection(
    private val onServiceConnected: (ComponentName, IBinder) -> Unit = { _, _ -> },
    private val onServiceDisconnected: (ComponentName) -> Unit = {},
) : ServiceConnection {
    override fun onServiceConnected(
        name: ComponentName,
        service: IBinder,
    ) = onServiceConnected.invoke(name, service)

    override fun onServiceDisconnected(name: ComponentName) = onServiceDisconnected.invoke(name)
}
