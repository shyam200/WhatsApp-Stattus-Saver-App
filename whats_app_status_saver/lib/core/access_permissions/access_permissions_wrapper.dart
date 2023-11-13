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
      return await Permission.storage.isGranted ||
          await Permission.storage.isLimited;
    }
    return false;
  }

  Future<bool> grantPermission() async {
    var permissionStatus = await Permission.storage.request();

    if (permissionStatus == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  Future<bool> isAndroidLessThan11() async {
    try {
      final String release =
          (await DeviceInfoPlugin().androidInfo).version.release;
      final releaseParts = release.split('.');
      final releaseVersion = int.parse(releaseParts[0]);
      return releaseVersion < 11;
    } catch (e) {
      return true;
    }
  }
}
