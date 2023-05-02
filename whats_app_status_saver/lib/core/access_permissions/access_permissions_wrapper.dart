import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saf/saf.dart';

import '../../resources/common_constants.dart';

/// Wrapper class over the methods used to get and request the status of the notification permission and location.
/// Decouple the libraries implementation to the bloc logic by using this class.
class AccessPermissionsWrapper {
  Future<bool> isGalleryPermissionAllowed() async {
    if (Platform.isIOS) {
      return await Permission.photos.isGranted ||
          await Permission.photos.isLimited;
    } else if (Platform.isAndroid) {
      if (await isAndroidGreaterThan10()) {
        // return await Permission.storage.isGranted ||
        //     await Permission.storage.isLimited;

      } else {
        return await Permission.storage.isGranted ||
            await Permission.storage.isLimited;
      }
    }
    return false;
  }

  Future<bool> checkAndRequestPermission(Saf dirPath) async {
    if (Platform.isAndroid && await isAndroidGreaterThan10()) {
      // return await Permission.storage.request();
      return await dirPath.getDirectoryPermission(isDynamic: true) ?? false;
    }

    // return PermissionStatus.denied;
    return false;
  }

  Future<bool> isAndroidGreaterThan10() async {
    final release = (await DeviceInfoPlugin().androidInfo).version.release;
    final releaseVersion = int.parse(release);
    return releaseVersion > 10;
  }

  Future<bool> isAndroidGreaterThan12() async {
    final release = (await DeviceInfoPlugin().androidInfo).version.release;
    final releaseVersion = int.parse(release);

    return releaseVersion > 12;
  }
}
