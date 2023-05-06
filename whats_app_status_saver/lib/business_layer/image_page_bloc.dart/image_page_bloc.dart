import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:share_plus/share_plus.dart';

import 'image_page_event.dart';
import 'image_page_state.dart';

class ImagePageBloc extends Bloc<ImagePageEvent, ImagePageState> {
  ImagePageBloc() : super(ImagePageInitialState()) {
    on<StatusImageDownloadEvent>(_downloadStatusImageOnGallery);
    on<StatusImageShareEvent>(_shareStatusImageOnSocial);
  }

//Method to save images to gallery in android and photos on IOS
  FutureOr<void> _downloadStatusImageOnGallery(
      StatusImageDownloadEvent event, Emitter<ImagePageState> emit) async {
    try {
      emit(ImagePageLoadingState());

      await GallerySaver.saveImage(event.url);
      emit(const GalleryImageDownloadedSuccessState());
    } catch (exception, stackTrace) {
      log('exception:- $exception \nstackTrace:- $stackTrace');
    }
  }

  FutureOr<void> _shareStatusImageOnSocial(
      StatusImageShareEvent event, Emitter<ImagePageState> emit) {
    try {
      final file = event.imageFile;
      Share.shareXFiles([XFile(file.path)],
          text: 'share image', subject: 'Ws Share');
    } catch (exception, stackTrace) {
      log('exception:- $exception \nstackTrace:- $stackTrace');
    }
  }
}
