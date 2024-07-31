import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class VideoPageState extends Equatable {
  const VideoPageState();
  @override
  List<Object?> get props => [];
}

class VideoPageInitialState extends VideoPageState {}

class VideoPageLoadingState extends VideoPageState {}

class GalleryVideoDownloadedSuccessState extends VideoPageState {
  const GalleryVideoDownloadedSuccessState();
}

class VideoAddedToWishlistState extends VideoPageState {}

class VideosThumbnailLoadedState extends VideoPageState {
  final List<File> videosThumbnail;

  const VideosThumbnailLoadedState(this.videosThumbnail);
  @override
  List<Object?> get props => [videosThumbnail];
}

class VideoDetailInitialisedtState extends VideoPageState {}

class TechnicalErrorState extends VideoPageState {}
