package cn.mf.flutter_code_test

import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.megretail.mpa/mainChannel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
                .setMethodCallHandler { call, result ->
                    when (call.method) {
                        "startTaskLoop" -> {
                            result.success("Android ${android.os.Build.VERSION.RELEASE}")
                            Log.i("menggod", "MainActivity.configureFlutterEngine--->startTaskLoop")
                        }
                        "stopTaskLoop" -> {
                            result.success("Android ${android.os.Build.VERSION.RELEASE}")
                            Log.i("menggod", "MainActivity.configureFlutterEngine--->stopTaskLoop")
                        }
                        else -> {
                            result.notImplemented()
                        }
                    }
                }
    }
}
