import 'package:equatable/equatable.dart';

abstract class MainPageState extends Equatable {}

class MainPageInitialState extends MainPageState {
  @override
  List<Object?> get props => [];
}

class MainPageLoadingState extends MainPageState {
  @override
  List<Object?> get props => [];
}

class MainPageDataLoadedState extends MainPageState {
  @override
  List<Object?> get props => [];
}

class GalleryPermissionGrantedState extends MainPageState {
  @override
  List<Object?> get props => [];
}

class GalleryPermissionTemporarilyDeniedState extends MainPageState {
  @override
  List<Object?> get props => [];
}

class GalleryPermissionPermanentlyDeniedState extends MainPageState {
  @override
  List<Object?> get props => [];
}
