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
