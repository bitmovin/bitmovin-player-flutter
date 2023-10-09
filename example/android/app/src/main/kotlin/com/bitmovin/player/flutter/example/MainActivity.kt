package com.bitmovin.player.flutter.example

import android.os.Bundle
import android.os.PersistableBundle
import android.util.Log
import com.google.android.gms.cast.framework.CastContext
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    @Override
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        try {
            // Load Google Cast context eagerly in order to ensure that
            // the cast state is updated correctly.
            CastContext.getSharedInstance(this, Runnable::run);
        } catch (e: Exception) {
            Log.w("MainActivity", "Could not initialize cast context", e)
        }
    }
}
