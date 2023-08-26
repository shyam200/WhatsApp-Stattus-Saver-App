//package com.mv.mvbarcodescan
//
//import android.app.Activity
//import android.content.Intent
//import android.os.Build
//import io.flutter.embedding.engine.plugins.FlutterPlugin
//import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
//import io.flutter.embedding.engine.plugins.activity.ActivityAware
//import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
//import io.flutter.plugin.common.MethodCall
//import io.flutter.plugin.common.MethodChannel
//import io.flutter.plugin.common.PluginRegistry.ActivityResultListener
//import io.flutter.plugin.common.PluginRegistry.Registrar
//
///**
// * MvbarcodescanPlugin
// */
//class MvbarcodescanPlugin : FlutterPlugin, MethodChannel.MethodCallHandler,
//    ActivityAware, ActivityResultListener {
//    private var channel: MethodChannel? = null
//    private var pendingResult: MethodChannel.Result? = null
//    override fun onAttachedToEngine(flutterPluginBinding: FlutterPluginBinding) {
//        channel = MethodChannel(flutterPluginBinding.flutterEngine.dartExecutor, channelName)
//        channel!!.setMethodCallHandler(this)
//    }
//
//    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
//        if (call.method == "getPlatformVersion") {
//            result.success("Android " + Build.VERSION.RELEASE)
//        } else if (call.method == "scan") {
//            pendingResult = result
//            val intent = Intent(
//                activity,
//                QrCodeScanActivity::class.java
//            )
//            activity!!.startActivityForResult(intent, REQUEST_CODE_FOR_QR_CODE_SCAN)
//        } else {
//            result.notImplemented()
//        }
//    }
//
//    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
//        channel!!.setMethodCallHandler(null)
//    }
//
//    override fun onAttachedToActivity(activityPluginBinding: ActivityPluginBinding) {
//        activity = activityPluginBinding.activity
//        activityPluginBinding.addActivityResultListener(this)
//    }
//
//    override fun onDetachedFromActivityForConfigChanges() {}
//    override fun onReattachedToActivityForConfigChanges(activityPluginBinding: ActivityPluginBinding) {}
//    override fun onDetachedFromActivity() {
//        activity = null
//    }
//
//    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
//        if (requestCode == REQUEST_CODE_FOR_QR_CODE_SCAN && data != null) {
//            if (resultCode == Activity.RESULT_OK) {
//                val qrCodeData = data.getStringExtra("BARCODE")
//                pendingResult!!.success(qrCodeData)
//            } else {
//                pendingResult!!.success("")
//            }
//            return true
//        }
//        return false
//    }
//
//    companion object {
//        private const val channelName = "mvbarcodescan"
//        private const val REQUEST_CODE_FOR_QR_CODE_SCAN = 2999
//        private var activity: Activity? = null
//        fun registerWith(registrar: Registrar) {
//            activity = registrar.activity()
//            val channel = MethodChannel(registrar.messenger(), channelName)
//            channel.setMethodCallHandler(MvbarcodescanPlugin())
//        }
//    }
//}