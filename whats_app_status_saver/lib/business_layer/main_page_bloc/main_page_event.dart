import 'package:equatable/equatable.dart';
import 'package:saf/saf.dart';

abstract class MainPageEvent extends Equatable {
  const MainPageEvent();
  @override
  List<Object?> get props => [];
}

class MainPageLoadingEvent extends MainPageEvent {}

class GetGalleryPermissionEvent extends MainPageEvent {}

class CheckGalleryPermissionStatusEvent extends MainPageEvent {}

// class GetStatusDownloadEvent extends MainPageEvent {
//   final String url;
//   final bool isVideoDetailView;

//   const GetStatusDownloadEvent(
//       {required this.url, required this.isVideoDetailView});

//   @override
//   List<Object?> get props => [url, isVideoDetailView];
// }

class GetStatusWishlistEvent extends MainPageEvent {}

class GetStatusShareEvent extends MainPageEvent {}

class GetWhatsAppStatusesEvent extends MainPageEvent {
  final Saf dirPath;
  // final bool isGranted;

  const GetWhatsAppStatusesEvent(this.dirPath);
  @override
  List<Object?> get props => [dirPath];
}

class ToggleDarkThemeModeEvent extends MainPageEvent {
  final bool isDarkMode;
  // final bool isGranted;

  const ToggleDarkThemeModeEvent(this.isDarkMode);
  @override
  List<Object?> get props => [isDarkMode];
}
