package com.bitmovin.player.flutter.example

import android.app.Notification
import android.app.Service
import android.content.Context
import android.content.Intent
import android.os.IBinder
import androidx.core.app.NotificationCompat
import com.bitmovin.player.api.Player
import com.bitmovin.player.api.ui.notification.CustomActionReceiver
import com.bitmovin.player.api.ui.notification.NotificationListener
import com.bitmovin.player.core.R
import com.bitmovin.player.flutter.PlayerManager
import com.bitmovin.player.ui.notification.DefaultMediaDescriptor
import com.bitmovin.player.ui.notification.PlayerNotificationManager

private const val NOTIFICATION_CHANNEL_ID = "custom.backgrounbd.playback.service"
private const val NOTIFICATION_ID = 1
private const val EMPTY_CHANNEL_DESCRIPTION = 0

class CustomBackgroundPlaybackService: Service() {
    private var player: Player? = null
    private lateinit var playerNotificationManager: PlayerNotificationManager

    private val customActionReceiver =
        object : CustomActionReceiver {
            override fun createCustomActions(context: Context): Map<String, NotificationCompat.Action> = emptyMap()

            override fun getCustomActions(player: Player) =
                if (!player.isPlaying) {
                    listOf(PlayerNotificationManager.ACTION_STOP)
                } else {
                    emptyList()
                }

            override fun onCustomAction(
                player: Player,
                action: String,
                intent: Intent,
            ) {
                if (action == PlayerNotificationManager.ACTION_STOP) stopSelf()
            }
        }

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onStartCommand(
        intent: Intent?,
        flags: Int,
        startId: Int,
    ): Int {
        player = PlayerManager.backgroundPlayer

        // Create a PlayerNotificationManager with the static create method
        // By passing null for the mediaDescriptionAdapter, a DefaultMediaDescriptionAdapter will be used internally.
        playerNotificationManager =
            PlayerNotificationManager.createWithNotificationChannel(
                this,
                NOTIFICATION_CHANNEL_ID,
                R.string.app_name, // TODO
                EMPTY_CHANNEL_DESCRIPTION,
                NOTIFICATION_ID,
                DefaultMediaDescriptor(assets),
                customActionReceiver,
            ).apply {
                setNotificationListener(
                    object : NotificationListener {
                        override fun onNotificationStarted(
                            notificationId: Int,
                            notification: Notification,
                        ) {
                            startForeground(notificationId, notification)
                        }

                        override fun onNotificationCancelled(notificationId: Int) {
                            stopSelf()
                        }
                    },
                )

                // Attaching the Player to the PlayerNotificationManager
                setPlayer(player)
            }

        return START_STICKY
    }
}
