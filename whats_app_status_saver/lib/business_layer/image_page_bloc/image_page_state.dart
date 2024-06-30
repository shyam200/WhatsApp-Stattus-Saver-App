import 'package:equatable/equatable.dart';

abstract class ImagePageState extends Equatable {
  const ImagePageState();
  @override
  List<Object?> get props => [];
}

class ImagePageInitialState extends ImagePageState {}

class ImagePageLoadingState extends ImagePageState {}

class GalleryImageDownloadedSuccessState extends ImagePageState {
  const GalleryImageDownloadedSuccessState();
}

class ImageAddedToWishlistState extends ImagePageState {}
