import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'video_page_event.dart';
import 'video_page_state.dart';

class VideoPageBloc extends Bloc<VideoPageEvent, VideoPageState> {
  VideoPageBloc() : super(VideoPageInitialState()) {
    on<GetStatusVideoDownloadEvent>(_downloadStatusVideoOnGallery);
    on<StatusVideoShareEvent>(_shareStatusVideoOnSocial);
    on<GenerateVideosThumbnailEvent>(_generateVideosThumbnail);
    on<StatusVideoInitialiseEvent>((event, emit) async {
      emit(VideoPageLoadingState());
      await Future.delayed(const Duration(milliseconds: 200));
      emit(VideoDetailInitialisedtState());
    });
  }

  //Method to save videos to gallery in android and photos on IOS
  FutureOr<void> _downloadStatusVideoOnGallery(
      GetStatusVideoDownloadEvent event, Emitter<VideoPageState> emit) async {
    try {
      emit(VideoPageLoadingState());

      await GallerySaver.saveVideo(event.url);
      emit(const GalleryVideoDownloadedSuccessState());
    } catch (exception, stackTrace) {
      log('exception:- $exception \nstackTrace:- $stackTrace');
    }
  }

//Share video on any social media platfrom present on device
  FutureOr<void> _shareStatusVideoOnSocial(
      StatusVideoShareEvent event, Emitter<VideoPageState> emit) {
    try {
      final file = event.videoFile;
      Share.shareXFiles([XFile(file.path)], subject: 'Ws Share');
    } catch (exception, stackTrace) {
      log('exception:- $exception \nstackTrace:- $stackTrace');
    }
  }

//Generate thumbnails from the given videos file list and return the thumbnails files
  FutureOr<void> _generateVideosThumbnail(
      GenerateVideosThumbnailEvent event, Emitter<VideoPageState> emit) async {
    try {
      emit(VideoPageLoadingState());

      List<File> thumbnails = [];
      for (File item in event.videoFiles) {
        final thumbnail = await VideoThumbnail.thumbnailFile(video: item.path);
        thumbnails.add(File(thumbnail ?? ''));
      }
      emit(VideosThumbnailLoadedState(thumbnails));
    } catch (exception, stackTrace) {
      log('exception:- $exception \nstackTrace:- $stackTrace');
    }
  }
}
