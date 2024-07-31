import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../core/local_storage/isar/isar_db_wrapper.dart';
import '../../data_layer/models/thumbnail_model.dart';
import 'video_page_event.dart';
import 'video_page_state.dart';

class VideoPageBloc extends Bloc<VideoPageEvent, VideoPageState> {
  final IsarDBWrapper isarDBWrapper;

  VideoPageBloc({required this.isarDBWrapper})
      : super(VideoPageInitialState()) {
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
      //logic to get the thumbnails from either DB or generate from scratch if needed
      List<File> thumbnails = [];
      List<String> thumbnailsPath = [];
      final storedThumbnails =
          await isarDBWrapper.getObject<ThumbnailsModel>() as ThumbnailsModel?;

      //if newly opened app or
      //if there is a change in the video files length(videos added/removed)
      if (storedThumbnails == null ||
          storedThumbnails.thumbnailsPath?.length != event.videoFiles.length) {
        //generate and store in db
        for (File item in event.videoFiles) {
          final thumbnail = await VideoThumbnail.thumbnailFile(
            video: item.path,
            imageFormat: ImageFormat.WEBP,
            quality: 10,
          );
          thumbnails.add(File(thumbnail ?? ''));
          thumbnailsPath.add(thumbnail ?? '');
        }
        await isarDBWrapper.deleteObject<ThumbnailsModel>();
        await isarDBWrapper.addObject<ThumbnailsModel>(
            dataObject: ThumbnailsModel(thumbnailsPath: thumbnailsPath));
      } else {
        for (var items in storedThumbnails.thumbnailsPath ?? []) {
          thumbnails.add(File(items));
        }
      }

      emit(VideosThumbnailLoadedState(thumbnails));
    } catch (exception) {
      //if anything wrong happens due to DB then clear the cache
      await isarDBWrapper.deleteDB();
      emit(TechnicalErrorState());
    }
  }
}
