import 'package:equatable/equatable.dart';
import 'package:saf/saf.dart';

abstract class MainPageEvent extends Equatable {
  const MainPageEvent();
  @override
  List<Object?> get props => [];
}

class MainPageLoadingEvent extends MainPageEvent {}

class GetGalleryPermissionEvent extends MainPageEvent {}

class GetGalleryPermissionStatusEvent extends MainPageEvent {}

class GetWhatsAppStatusesEvent extends MainPageEvent {
  final Saf dirPath;
  // final bool isGranted;

  const GetWhatsAppStatusesEvent(this.dirPath);
  @override
  List<Object?> get props => [dirPath];
}
