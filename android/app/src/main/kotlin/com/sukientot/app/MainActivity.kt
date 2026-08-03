package com.sukientot.app

import android.media.AudioManager
import android.media.Ringtone
import android.media.RingtoneManager
import android.media.ToneGenerator
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channelName = "com.sukientot.app/call_audio"
    private var ringtone: Ringtone? = null
    private var toneGenerator: ToneGenerator? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "playIncoming" -> {
                        playIncomingRingtone()
                        result.success(null)
                    }
                    "playOutgoing" -> {
                        playOutgoingTone()
                        result.success(null)
                    }
                    "stop" -> {
                        stopCallAudio()
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun playIncomingRingtone() {
        stopCallAudio()
        val uri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_RINGTONE)
        ringtone = RingtoneManager.getRingtone(applicationContext, uri)?.apply {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) isLooping = true
            play()
        }
    }

    private fun playOutgoingTone() {
        stopCallAudio()
        toneGenerator = ToneGenerator(AudioManager.STREAM_VOICE_CALL, 70).apply {
            startTone(ToneGenerator.TONE_SUP_RINGTONE)
        }
    }

    private fun stopCallAudio() {
        ringtone?.stop()
        ringtone = null
        toneGenerator?.stopTone()
        toneGenerator?.release()
        toneGenerator = null
    }

    override fun onDestroy() {
        stopCallAudio()
        super.onDestroy()
    }
}
