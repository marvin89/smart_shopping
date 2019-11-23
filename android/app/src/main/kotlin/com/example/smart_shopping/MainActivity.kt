package com.example.smart_shopping

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import com.google.android.gms.actions.NoteIntents


class MainActivity: FlutterActivity() {

  private var sharedText: String? = null

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    handleShareIntent()

    MethodChannel(flutterView, "app.channel.shared.data")
        .setMethodCallHandler { call, result ->
            when {
                call.method == "getSavedNote" -> result.success(sharedText)
                else -> result.notImplemented();
            }
    }
  }

  fun handleShareIntent() {
    val action = intent.action
    val type = intent.type

    handleSendText(intent)
  }

  fun handleSendText(intent: Intent) {
      sharedText = intent.getStringExtra(Intent.EXTRA_TEXT)
  }
}