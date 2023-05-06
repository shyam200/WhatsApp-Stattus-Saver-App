import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class VideoPageEvent extends Equatable {
  const VideoPageEvent();
  @override
  List<Object?> get props => [];
}

class GetStatusVideoDownloadEvent extends VideoPageEvent {
  final String url;

  const GetStatusVideoDownloadEvent({required this.url});

  @override
  List<Object?> get props => [url];
}

class StatusVideoShareEvent extends VideoPageEvent {
  final File videoFile;

  const StatusVideoShareEvent(this.videoFile);
  @override
  List<Object?> get props => [videoFile];
}

class StatusVideoWishlistAddEvent extends VideoPageEvent {}
