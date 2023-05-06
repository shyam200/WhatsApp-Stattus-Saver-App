import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:share_plus/share_plus.dart';

import 'video_page_event.dart';
import 'video_page_state.dart';

class VideoPageBloc extends Bloc<VideoPageEvent, VideoPageState> {
  VideoPageBloc() : super(VideoPageInitialState()) {
    on<GetStatusVideoDownloadEvent>(_downloadStatusVideoOnGallery);
    on<StatusVideoShareEvent>(_shareStatusVideoOnSocial);
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

  FutureOr<void> _shareStatusVideoOnSocial(
      StatusVideoShareEvent event, Emitter<VideoPageState> emit) {
    try {
      final file = event.videoFile;
      Share.shareXFiles([XFile(file.path)], subject: 'Ws Share');
    } catch (exception, stackTrace) {
      log('exception:- $exception \nstackTrace:- $stackTrace');
    }
  }
}
