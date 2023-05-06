import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';

import 'image_page_event.dart';
import 'image_page_state.dart';

class ImagePageBloc extends Bloc<ImagePageEvent, ImagePageState> {
  ImagePageBloc() : super(ImagePageInitialState()) {
    on<GetStatusImageDownloadEvent>(_downloadStatusImageOnGallery);
  }

//Method to save images to gallery in android and photos on IOS
  FutureOr<void> _downloadStatusImageOnGallery(
      GetStatusImageDownloadEvent event, Emitter<ImagePageState> emit) async {
    try {
      emit(ImagePageLoadingState());

      await GallerySaver.saveImage(event.url);
      emit(const GalleryImageDownloadedSuccessState());
    } catch (exception, stackTrace) {
      log('exception:- $exception \nstackTrace:- $stackTrace');
    }
  }
}
