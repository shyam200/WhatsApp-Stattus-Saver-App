//package com.example.whats_app_status_saver
//
//import android.content.Intent
//import com.mv.mvbarcodescan.MvbarcodescanPlugin
//import io.flutter.embedding.engine.plugins.FlutterPlugin
//import io.flutter.embedding.engine.plugins.FlutterPlugin.*
//import io.flutter.embedding.engine.plugins.activity.ActivityAware
//import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
//import io.flutter.plugin.common.MethodCall
//import io.flutter.plugin.common.MethodChannel
//import io.flutter.plugin.common.PluginRegistry
//
//class WsFilePickerPlugin :  FlutterPlugin, MethodChannel.MethodCallHandler,
//    ActivityAware, PluginRegistry.ActivityResultListener {
//    private var channel: MethodChannel? = null
//    private var pendingResult: MethodChannel.Result? = null
//
//    override fun onAttachedToEngine(binding: FlutterPluginBinding) {
//        channel = MethodChannel(binding.flutterEngine.dartExecutor,
//            MvbarcodescanPlugin.channelName
//        )
//        channel!!.setMethodCallHandler(this)
//    }
//
//    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
//        TODO("Not yet implemented")
//    }
//
//    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
//        TODO("Not yet implemented")
//    }
//
//    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
//        TODO("Not yet implemented")
//    }
//
//    override fun onDetachedFromActivityForConfigChanges() {
//        TODO("Not yet implemented")
//    }
//
//    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
//        TODO("Not yet implemented")
//    }
//
//    override fun onDetachedFromActivity() {
//        TODO("Not yet implemented")
//    }
//
//    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
//        TODO("Not yet implemented")
//    }
//}