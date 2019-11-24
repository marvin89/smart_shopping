package com.example.smart_shopping

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter


class MainActivity: FlutterActivity() {

  private var sharedText: String? = null

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    handleShareIntent(getIntent())

    MethodChannel(flutterView, "app.channel.shared.data")
        .setMethodCallHandler { call, result ->
            when {
                call.method == "getSavedNote" -> result.success(sharedText)
                else -> result.notImplemented();
            }
    }
  }

  override fun onNewIntent(intent: Intent) {
    super.onNewIntent(intent)
    handleVoiceSearch(intent)
  }

  fun handleVoiceSearch(intent: Intent) {
    val action = intent.action
    val type = intent.type

    handleShareIntent(intent)
  }

  fun handleShareIntent(intent: Intent) {
      sharedText = intent.getStringExtra(Intent.EXTRA_TEXT)
  }
}