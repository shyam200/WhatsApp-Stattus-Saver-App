import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/access_permissions/access_permissions_wrapper.dart';
import '../../core/method_channels/ws_platform_channel.dart';
import '../../injection/injection_container.dart';
import 'main_page_event.dart';
import 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final AccessPermissionsWrapper accessPermissionsWrapper;
  final SharedPreferences sharedPreferences;
  MainPageBloc({
    required this.accessPermissionsWrapper,
    required this.sharedPreferences,
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
    final isPermissionAllowed =
        await di<WSPlatformChannel>().isPermissionAllowed();
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

    var result = await di<WSPlatformChannel>().getCacheFilesPath();

    var filesList = List<String>.from(result);

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

    //Ask directory permission
    var isSuccess = await di<WSPlatformChannel>().getDirectoryPermission();
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
      ToggleDarkThemeModeEvent event, Emitter<MainPageState> emit) {
    emit(MainPageLoadingState());
    emit(ToggleDarkThemeModeState(event.isDarkMode));
  }
}
