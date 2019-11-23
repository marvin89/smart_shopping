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

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    // Intent intent = getIntent()
    //     String action = intent.getAction()
    //     String type = intent.getType()

    //     if (NoteIntents.ACTION_CREATE_NOTE.equals(action) && type != null) {
    //         if ("text/plain".equals(type)) {
    //             savedNote = intent.getStringExtra(Intent.EXTRA_TEXT)
    //         }
    //     }
    
    MethodChannel(flutterView, "app.channel.shared.data")
        .setMethodCallHandler { call, result -> {
            if(call.method == "getSavedNote") {
                result.success(getSavedNote())
            } else {
                result.notImplemented()
            }

        // @Override
        //     public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        //         if (methodCall.method.contentEquals("getSavedNote")) {
        //             result.success(savedNote)
        //             savedNote = null
        //         }
        //     }
        // });
        }
    }
  }

  private fun getSavedNote(): String {
      val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(NoteIntents.ACTION_CREATE_NOTE))
      return intent!!.getStringExtra(Intent.EXTRA_TEXT)
  }
}