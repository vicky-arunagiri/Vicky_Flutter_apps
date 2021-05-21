package com.example.player_app

import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onPause() {
        super.onPause()
        window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
    }

    override fun onResume() {
        super.onResume()
        window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
    }
}
