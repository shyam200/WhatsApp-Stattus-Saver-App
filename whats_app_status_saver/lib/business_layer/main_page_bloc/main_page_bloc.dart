import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/access_permissions/access_permissions_wrapper.dart';
import '../../core/local_storage/shared_preference_manager.dart';
import '../../core/method_channels/ws_platform_channel.dart';
import '../../injection/injection_container.dart';
import '../../resources/common_constants.dart';
import '../../resources/preference_keys.dart';
import 'main_page_event.dart';
import 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final AccessPermissionsWrapper accessPermissionsWrapper;
  final SharedPreferenceManager sharedPreferenceManager;
  MainPageBloc({
    required this.accessPermissionsWrapper,
    required this.sharedPreferenceManager,
  }) : super(MainPageInitialState()) {
    on<CheckGalleryPermissionStatusEvent>(_checkPermissionStatus);
    on<GetWsFilesEvent>(_getWsFiles);
    on<GetGalleryPermissionEvent>(_getFileAccessPermission);
    on<ToggleDarkThemeModeEvent>(_switchThemeAppMode);
  }

//Method to check the permission status if user has already granted
  void _checkPermissionStatus(CheckGalleryPermissionStatusEvent event,
      Emitter<MainPageState> emit) async {
    emit(MainPageLoadingState());
    bool isPermissionAllowed = false;
    if (await accessPermissionsWrapper.isAndroidLessThan11()) {
      isPermissionAllowed =
          await accessPermissionsWrapper.isGalleryPermissionAllowed();
    } else {
      isPermissionAllowed = await di<WSPlatformChannel>().isPermissionAllowed();
    }

    // sharedPreferences.getBool(CommonConstants.permissionStatusKey) ?? false;

    if (isPermissionAllowed) {
      emit(GalleryPermissionAllowedState());
    } else {
      emit(GalleryPermissionNotAllowedState());
      // emit(GalleryPermissionDialogState());
    }
  }

  void _getWsFiles(GetWsFilesEvent event, Emitter<MainPageState> emit) async {
    emit(MainPageLoadingState());
    var filesList = [];
    if (await accessPermissionsWrapper.isAndroidLessThan11()) {
      // var path = (await getExternalStorageDirectory())
      //     ?.parent
      //     .parent
      //     .parent
      //     .parent
      //     .absolute
      //     .path;

      var dir = Directory(CommonConstants.android9Path);
      List<FileSystemEntity> files = [];
      if (dir.existsSync()) {
        files = dir.listSync();
      } else {
        emit(TechnicalErrorState());
        return;
      }
      for (var file in files) {
        filesList.add(file.path);
      }
    } else {
      var result = await di<WSPlatformChannel>().getCacheFilesPath();
      filesList = List<String>.from(result);
    }

    List<File> imageFileList = [];
    List<File> videosFileList = [];

    for (var path in filesList) {
      if (path.endsWith('.jpg')) {
        imageFileList.add(File(path));
      } else if (path.endsWith('.mp4')) {
        videosFileList.add(File(path));
      }
    }

    emit(GalleryFilesLoadedState(
        imageFilesList: imageFileList, videoFilesList: videosFileList));
  }

  void _getFileAccessPermission(
      MainPageEvent event, Emitter<MainPageState> emit) async {
    emit(MainPageLoadingState());
    var isSuccess = false;
    if (await accessPermissionsWrapper.isAndroidLessThan11()) {
      isSuccess = await accessPermissionsWrapper.grantPermission();
    } else {
      //Ask directory permission
      isSuccess = await di<WSPlatformChannel>().getDirectoryPermission();
    }

    if (isSuccess) {
      emit(GalleryPermissionAllowedState());
    } else {
      //if permission not granted due to any reason
      emit(TechnicalErrorState());
    }
  }

  // _checkAndSetPermission(bool isGranted) async {
  //   final isPermissionAllowed =
  //       sharedPreferences.getBool(CommonConstants.permissionStatusKey) ?? false;
  //   if (!isPermissionAllowed) {
  //     await sharedPreferences.setBool(
  //         CommonConstants.permissionStatusKey, isGranted);
  //   }
  // }

  // void _getWhatsAppStatuses(
  //     GetWhatsAppStatusesEvent event, Emitter<MainPageState> emit) async {
  //   emit(MainPageLoadingState());

  //   List<String> imagePaths = [];
  //   List<File> videosFileList = [];

  //   log('listed file:--- $imagePaths');

  //   emit(GalleryFilesLoadedState(
  //       imageFilesList: event.imageList, videoFilesList: videosFileList));
  // }

//To switch between app themes
  void _switchThemeAppMode(
      ToggleDarkThemeModeEvent event, Emitter<MainPageState> emit) async {
    emit(MainPageLoadingState());
    await sharedPreferenceManager.setBool(
        PrefKeys.isDarkMode, event.isDarkMode);
    emit(ToggleDarkThemeModeState(event.isDarkMode));
  }
}
