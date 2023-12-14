package com.bitmovin.player.flutter.example

import android.os.Bundle
import android.util.Log
import android.view.WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON
import com.google.android.gms.cast.framework.CastContext
import io.flutter.embedding.android.FlutterFragmentActivity

// The cast functionality in the Bitmovin Player SDK requires the Activity to be a subclass of `FragmentActivity`.
class MainActivity : FlutterFragmentActivity() {
    @Override
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        try {
            // Load Google Cast context eagerly in order to ensure that
            // the cast state is updated correctly.
            CastContext.getSharedInstance(this, Runnable::run)
        } catch (e: Exception) {
            Log.w("MainActivity", "Could not initialize cast context", e)
        }

        // Prevent going into ambient mode on Android TV devices / screen timeout on mobile devices during playback.
        // If your app uses multiple activities make sure to add this flag to the activity that hosts the player.
        // Reference: https://developer.android.com/training/scheduling/wakelock#screen
        window.addFlags(FLAG_KEEP_SCREEN_ON)
    }
}
