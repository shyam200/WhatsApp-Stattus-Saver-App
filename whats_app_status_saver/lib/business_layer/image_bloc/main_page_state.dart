import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:saf/saf.dart';

abstract class MainPageState extends Equatable {
  const MainPageState();
  @override
  List<Object?> get props => [];
}

class MainPageInitialState extends MainPageState {}

class MainPageLoadingState extends MainPageState {}

class MainPageDataLoadedState extends MainPageState {}

class GalleryPermissionGrantedState extends MainPageState {
  final Saf dirPath;

  const GalleryPermissionGrantedState(this.dirPath);
  @override
  List<Object?> get props => [dirPath];
}

class GalleryPermissionDialogState extends MainPageState {}

class GalleryPermissionAllowedState extends MainPageState {}

class GalleryPermissionTemporarilyDeniedState extends MainPageState {}

class GalleryPermissionPermanentlyDeniedState extends MainPageState {}

class GalleryFilesLoadedState extends MainPageState {
  final List<File>? filesList;

  const GalleryFilesLoadedState({required this.filesList});
  @override
  List<Object?> get props => [filesList];
}
