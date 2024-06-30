import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ImagePageEvent extends Equatable {
  const ImagePageEvent();
  @override
  List<Object?> get props => [];
}

class ImagePageInitialEvent extends ImagePageEvent {}

class StatusImageDownloadEvent extends ImagePageEvent {
  final String url;

  const StatusImageDownloadEvent({required this.url});

  @override
  List<Object?> get props => [url];
}

class StatusImageShareEvent extends ImagePageEvent {
  final File imageFile;

  const StatusImageShareEvent(this.imageFile);
  @override
  List<Object?> get props => [imageFile];
}

class StatusImageWishlistAddEvent extends ImagePageEvent {}
