package com.bitmovin.player.flutter

import android.content.Context
import android.content.Intent
import android.media.AudioManager
import android.net.Uri
import android.os.Build
import android.provider.Settings
import androidx.annotation.RequiresApi
import androidx.core.content.ContextCompat

class Helper {
    companion object {
        fun secondsToMillis(seconds: Double): Double = seconds * 1000

        fun millisToSeconds(millis: Double): Double = millis / 1000

        fun normalize(
            x: Float,
            inMin: Float,
            inMax: Float,
            outMin: Float,
            outMax: Float,
        ): Float {
            val outRange = outMax - outMin
            val inRange = inMax - inMin
            return (x - inMin) * outRange / inRange + outMin
        }

        fun getSystemBrightness(context: Context): Float {
            return Settings.System.getInt(
                context.contentResolver,
                Settings.System.SCREEN_BRIGHTNESS,
                0,
            ).toFloat()
        }

        @RequiresApi(Build.VERSION_CODES.M)
        fun canWriteSystemSettings(context: Context): Boolean {
            return Settings.System.canWrite(context)
        }

        fun requestSystemWritePermission(context: Context) {
            val intent = Intent(Settings.ACTION_MANAGE_WRITE_SETTINGS).apply {
                data = Uri.parse("package:" + context.packageName)
            }
            ContextCompat.startActivity(context, intent, null)
        }

        fun getAudio(context: Context): AudioManager {
            return context.getSystemService(Context.AUDIO_SERVICE) as AudioManager
        }
    }
}
