import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

/// Wrapper class over the methods used to get and request the status of the notification permission and location.
/// Decouple the libraries implementation to the bloc logic by using this class.
class AccessPermissionsWrapper {
  Future<bool> isGalleryPermissionAllowed() async {
    if (Platform.isIOS) {
      return await Permission.photos.isGranted ||
          await Permission.photos.isLimited;
    } else if (Platform.isAndroid) {
      if (await isLessThanAndroid13()) {
        return await Permission.storage.isGranted ||
            await Permission.storage.isLimited;
      } else {
        return await Permission.photos.isGranted ||
            await Permission.photos.isLimited;
      }
    }
    return false;
  }

  Future<PermissionStatus> requestGalleryPermission() async {
    if (Platform.isIOS) {
      return await Permission.photos.request();
    } else if (Platform.isAndroid) {
      //check if android version is less than 13 then request old way
      if (await isLessThanAndroid13()) {
        return await Permission.storage.request();
      } else {
        return await Permission.photos.request();
      }
    }
    return PermissionStatus.denied;
  }

  Future<bool> isLessThanAndroid13() async {
    final release = (await DeviceInfoPlugin().androidInfo).version.release;
    final releaseVersion = int.parse(release);
    return releaseVersion < 13;
  }
}
