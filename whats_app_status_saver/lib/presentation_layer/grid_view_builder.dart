import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:whats_app_status_saver/business_layer/image_bloc/main_page_bloc.dart';
import 'package:whats_app_status_saver/business_layer/image_bloc/main_page_event.dart';
import 'package:whats_app_status_saver/presentation_layer/video_page/video_detail_page.dart';

import '../resources/dimension_keys.dart';
import '../resources/margin_keys.dart';
import 'image_page/image_detail_page.dart';

class GridViewBuilder extends StatelessWidget {
  final int itemCount;
  final bool isVideoView;
  final MainPageBloc bloc;
  final List<File>? filesPath;
  final List<File> thumbnails;
  final List<File>? videoFiles;

  const GridViewBuilder(
      {Key? key,
      required this.itemCount,
      required this.bloc,
      this.isVideoView = false,
      this.filesPath,
      this.thumbnails = const [],
      this.videoFiles = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return filesPath != null || thumbnails.isNotEmpty
        ? GridView.builder(
            itemCount: isVideoView ? thumbnails.length : filesPath?.length ?? 0,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: MarginKeys.gridMainAxisSpacing,
              crossAxisSpacing: MarginKeys.gridCrossAxisSpacing,
            ),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.green,
                      width: 8,
                    )),
                child: InkWell(
                  onTap: () {
                    // bloc.add(MainPageLoadingEvent());
                    isVideoView
                        ? Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => VideoDetailPage(
                                  video: videoFiles![index],
                                )))
                        : Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => ImageDetailPage(
                                  bloc: bloc,
                                  image: filesPath![index],
                                )));
                  },
                  child: SizedBox(
                    width: DimensionKeys.imageWeight,
                    height: DimensionKeys.imageHeight,
                    child: Image.file(
                      isVideoView ? thumbnails[index] : filesPath![index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            })
        : const SizedBox();
  }
}
