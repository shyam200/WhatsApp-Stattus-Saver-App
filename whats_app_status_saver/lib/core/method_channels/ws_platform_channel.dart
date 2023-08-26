import 'dart:developer';

import 'package:flutter/services.dart';

///This is wrapper class over Method [Platform channel] to [call kotlin native code]
class WSPlatformChannel {
  static const MethodChannel channel =
      MethodChannel("com.example.whats_app_status_saver/wsData");

  static const kCheckDirectoryPermission = "checkedDirPermission";
  static const kGetCacheFiles = "getCacheFiles";
  static const kGetDirectoryPermission = "getDirectoryPermission";

  //Call native method to check if permission of the WS directory is allowed of not
  Future isPermissionAllowed() async {
    try {
      return await channel.invokeMethod(kCheckDirectoryPermission);
    } catch (ex) {
      log("Unable to invoke check directory permission \nex");
    }
  }

  Future getDirectoryPermission() async {
    try {
      return await channel.invokeMethod(kGetDirectoryPermission);
    } catch (ex) {
      log("Unable to invoke get directory permission \nex");
    }
  }

//call method to invoke the method from native code
  Future getCacheFilesPath<T>() async {
    try {
      return await channel.invokeMethod(kGetCacheFiles);
    } catch (ex) {
      log('Unable to invoke getCache Files code \n$ex');
    }
  }
}
