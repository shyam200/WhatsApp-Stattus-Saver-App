import 'dart:io';

import 'package:flutter/material.dart';
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
  const GridViewBuilder(
      {Key? key,
      required this.itemCount,
      required this.bloc,
      this.isVideoView = false,
      this.filesPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return filesPath != null
        ? GridView.builder(
            itemCount: filesPath?.length ?? 0,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: MarginKeys.gridMainAxisSpacing,
              crossAxisSpacing: MarginKeys.gridCrossAxisSpacing,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  // bloc.add(MainPageLoadingEvent());
                  isVideoView
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const VideoDetailPage()))
                      : Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => ImageDetailPage(bloc: bloc)));
                },
                child: SizedBox(
                  width: DimensionKeys.imageWeight,
                  height: DimensionKeys.imageHeight,
                  child: Image.file(
                    filesPath![index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            })
        : const SizedBox();
  }
}
