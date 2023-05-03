import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../business_layer/image_bloc/main_page_bloc.dart';
import '../../resources/margin_keys.dart';
import '../grid_view_builder.dart';

class Videopage extends StatefulWidget {
  final MainPageBloc bloc;
  final List<File> filesList;
  const Videopage({super.key, required this.bloc, required this.filesList});

  @override
  State<Videopage> createState() => _VideopageState();
}

class _VideopageState extends State<Videopage> {
  List<File> thumbnails = [];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // setState(() {
      _getVideosThumbnail();
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.grey,
      padding: const EdgeInsets.symmetric(
        horizontal: MarginKeys.commonHorzontalAndVerticalPadding,
        vertical: MarginKeys.commonHorzontalAndVerticalPadding,
      ),
      child: widget.filesList.isNotEmpty
          ? thumbnails.isNotEmpty
              ? GridViewBuilder(
                  bloc: widget.bloc,
                  itemCount: widget.filesList.length,
                  isVideoView: true,
                  videoFiles: widget.filesList,
                  thumbnails: thumbnails)
              : const Center(
                  child: CircularProgressIndicator(),
                )
          : const Center(
              child: Text('No Video found!'),
            ),
    ));
  }

  Future _getVideosThumbnail() async {
    for (File item in widget.filesList) {
      // thumbnails.add(item.path);
      final thumbnail = await VideoThumbnail.thumbnailFile(video: item.path);
      thumbnails.add(File(thumbnail ?? ''));
    }
    setState(() {});
  }
}
