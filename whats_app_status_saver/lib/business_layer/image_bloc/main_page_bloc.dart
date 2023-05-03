import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saf/saf.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/access_permissions/access_permissions_wrapper.dart';
import '../../resources/common_constants.dart';
import 'main_page_event.dart';
import 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final AccessPermissionsWrapper accessPermissionsWrapper;
  final SharedPreferences sharedPreferences;
  MainPageBloc(
      {required this.accessPermissionsWrapper, required this.sharedPreferences})
      : super(MainPageInitialState()) {
    on<GetGalleryPermissionStatusEvent>(_checkPermissionStatus);
    on<GetGalleryPermissionEvent>(_getFileAccessPermission);
    on<GetWhatsAppStatusesEvent>(_getWhatsAppStatuses);
  }

//Method to check the permission status if user has already granted
  void _checkPermissionStatus(
      MainPageEvent event, Emitter<MainPageState> emit) {
    final isPermissionAllowed =
        sharedPreferences.getBool(CommonConstants.permissionStatusKey) ?? false;

    if (isPermissionAllowed) {
      emit(GalleryPermissionAllowedState());
    } else {
      emit(GalleryPermissionDialogState());
    }
  }

  void _getFileAccessPermission(
      MainPageEvent event, Emitter<MainPageState> emit) async {
    emit(MainPageLoadingState());
    //GRANT permission
    // HANDLE CASE FOR ANDROID > 10
    final url = Uri(path: CommonConstants.whatsAppStatusAndroidPath);
    Saf dirPath = Saf(url.toString());

    final isGranted =
        await accessPermissionsWrapper.checkAndRequestPermission(dirPath);

    if (isGranted) {
      _checkAndSetPermission(isGranted);
      emit(GalleryPermissionGrantedState(dirPath));
    } else {
      emit(GalleryPermissionTemporarilyDeniedState());
    }
  }

  _checkAndSetPermission(bool isGranted) async {
    final isPermissionAllowed =
        sharedPreferences.getBool(CommonConstants.permissionStatusKey) ?? false;
    if (!isPermissionAllowed) {
      await sharedPreferences.setBool(
          CommonConstants.permissionStatusKey, isGranted);
    }
  }

  void _getWhatsAppStatuses(
      GetWhatsAppStatusesEvent event, Emitter<MainPageState> emit) async {
    emit(MainPageLoadingState());

    List<String> imagePaths = [];
    List<String> videosPaths = [];
    List<File> imageFileList = [];
    List<File> videosFileList = [];
    var cachedFilesPath = await event.dirPath.cache();
    // await dirPath.sync();

    if (cachedFilesPath != null) {
      //load images

      for (String path in cachedFilesPath) {
        if (path.endsWith(".jpg")) {
          imagePaths.add(path);
        } else if (path.endsWith('.mp4')) {
          videosPaths.add(path);
        }
      }
    }
    //CREATE FILE WITH imagePaths

    for (var path in imagePaths) {
      imageFileList.add(File(path));
    }

    for (var path in videosPaths) {
      videosFileList.add(File(path));
    }

    log('listed file:--- $imagePaths');

    emit(GalleryFilesLoadedState(
        imageFilesList: imageFileList, videoFilesList: videosFileList));
    // await _getGalleryPermission(event, emit);
    // //load whatsApp statuses from Application directory
    // final directoryExt = await getExternalStorageDirectory();
    // log(directoryExt!.path);

    // final directory = Directory(
    //     "/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses");
    // if (directory.existsSync()) {
    //   final items = directory.listSync();
    //   log(items.toString());
    // } else {
    //   log('whatsApp not exists');
    // }
    // whatsAppDirectory.
  }
  // Future _getGalleryPermission(
  //     MainPageEvent event, Emitter<MainPageState> emit) async {
  //   // emit(MainPageLoadingState());
  //   //check if permission is already granted
  //   final isPermissionAllowed =
  //       await accessPermissionsWrapper.isGalleryPermissionAllowed();
  //   if (isPermissionAllowed) {
  //     // emit(GalleryPermissionGrantedState());
  //     return true;
  //   }

  //   // PermissionStatus galleryPermissionStatus =
  //   //     await accessPermissionsWrapper.checkAndRequestPermission();

  //   if (galleryPermissionStatus.isDenied) {
  //     return false; // emit(GalleryPermissionTemporarilyDeniedState());
  //   } else if (galleryPermissionStatus.isPermanentlyDenied ||
  //       galleryPermissionStatus.isRestricted) {
  //     return false; // emit(GalleryPermissionPermanentlyDeniedState());
  //   } else if (galleryPermissionStatus.isGranted ||
  //       galleryPermissionStatus.isLimited) {
  //     return true; // emit(GalleryPermissionGrantedState());
  //   }
  //   // log('permission status:----$permissionStatus');
  // }

//   void _getFilesItemsOnOlderAndroid(event, emit) async {
//     List<File> filesList = [];
// //HANDLE CASE FOR ANDROID <= 10
//     await _getGalleryPermission(event, emit);
//     final directory = Directory(
//         "/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses");
//     if (directory.existsSync()) {
//       final items = directory.listSync();
//       log(items.toString());
//       for (var element in items) {
//         filesList.add(File(element.path));
//       }
//     } else {
//       log('whatsApp not exists');
//     }
//     log('permanent file list---$_imgFilesList');
//   }
}

//Request access to /status folder from User
// final result = await FilePicker.platform.getDirectoryPath(
//     initialDirectory: CommonConstants.whatsAppStatusAndroidPath);
// if (result != null) {
// await FilePicker.platform.pickFiles()
// final bytes = result.files.single.bytes!;
// Use the bytes variable to access the selected hidden file
// log('bytes :---$bytes');

// final data = FilePicker.platform.pickFiles(
//     allowMultiple: false,
//     type: FileType.any,
//     // allowedExtensions: ['.*'],
//     withData: true,
//     initialDirectory: CommonConstants.whatsAppStatusAndroidPath);

// final status = await accessPermissionsWrapper.requestGalleryPermission();
// if (status.isGranted) {
//   final data = Directory(CommonConstants.whatsAppStatusAndroidPath);
//   if (data.existsSync()) {
//     final bytes = data.listSync().toString();

//     log('bytes :---$bytes');
//   } else {
//     log('file not exists');
//   }
// }
// List? filesPath = await dirPath.getFilesPath(fileType: "any");

//     List? cache = await dirPath.cache();
//     log('cache lenght;---------${cache?.length}');

//     log('cache------$cache');
//     cache?.clear();
// // if (isCached != null && isCached) {
// //   // Perform some file operations
// // } else {
// //   // failed to cache
// // }

// List<String>? cachedFilesPath = await dirPath.getCachedFilesPath();
// log('cache------$cachedFilesPath');
// bool? isGranted = await dirPath.sync();
// final x = Directory('fdsfs');
// final y = x.listSync();
    // // final dir = await getExternalStorageDirectory();
    // final dir = await getExternalStorageDirectory();
    // final extds = await getExternalStorageDirectories();
    // final applicationDir = await getApplicationDocumentsDirectory();
    // // final lib = await getLibraryDirectory();