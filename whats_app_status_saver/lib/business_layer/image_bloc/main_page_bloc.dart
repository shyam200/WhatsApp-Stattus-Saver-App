import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:whats_app_status_saver/core/access_permissions/access_permissions_wrapper.dart';
import 'package:whats_app_status_saver/resources/common_constants.dart';

import 'main_page_event.dart';
import 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final AccessPermissionsWrapper accessPermissionsWrapper;
  MainPageBloc({required this.accessPermissionsWrapper})
      : super(MainPageInitialState()) {
    on<GetGalleryPermissionEvent>(_getGalleryPermission);
    on<GetWhatsAppStatusesEvent>(_getWhatsAppStatuses);
  }

  // void _onLoading(MainPageEvent event, Emitter<MainPageState> emit) async {
  //   // print('loading.....');
  //   // emit(MainPageLoadingState());
  //   // print('loading completed......');
  //   // emit(MainPageDataLoadedState());
  // }

  void _getGalleryPermission(
      MainPageEvent event, Emitter<MainPageState> emit) async {
    emit(MainPageLoadingState());
    //check if permission is already granted
    final isPermissionAllowed =
        await accessPermissionsWrapper.isGalleryPermissionAllowed();
    if (isPermissionAllowed) {
      emit(GalleryPermissionGrantedState());
      return;
    }

    PermissionStatus galleryPermissionStatus =
        await accessPermissionsWrapper.requestGalleryPermission();

    if (galleryPermissionStatus.isDenied) {
      emit(GalleryPermissionTemporarilyDeniedState());
    } else if (galleryPermissionStatus.isPermanentlyDenied ||
        galleryPermissionStatus.isRestricted) {
      emit(GalleryPermissionPermanentlyDeniedState());
    } else if (galleryPermissionStatus.isGranted ||
        galleryPermissionStatus.isLimited) {
      emit(GalleryPermissionGrantedState());
    }
    // log('permission status:----$permissionStatus');
  }

  void _getWhatsAppStatuses(
      MainPageEvent event, Emitter<MainPageState> emit) async {
    emit(MainPageLoadingState());

    //load whatsApp statuses from Application directory
    final directory = await getExternalStorageDirectory();
    log(directory!.path);

    final whatsAppDirectory =
        Directory(CommonConstants.whatsAppStatusAndroidPath);
    if (whatsAppDirectory.existsSync()) {
      final items = whatsAppDirectory.listSync();
      log(items.toString());
    } else {
      log('whatsApp not exists');
    }
    // whatsAppDirectory.
  }
}
