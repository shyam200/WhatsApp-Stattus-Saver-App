import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'video_detail_page.dart';

import '../../business_layer/video_page_bloc.dart/video_page_bloc.dart';
import '../../injection/injection_container.dart';
import '../../resources/margin_keys.dart';
import '../../resources/text_styles.dart';
import '../grid_view_builder.dart';

class Videopage extends StatefulWidget {
  final List<File> filesList;
  const Videopage({super.key, required this.filesList});

  @override
  State<Videopage> createState() => _VideopageState();
}

class _VideopageState extends State<Videopage> {
  late VideoPageBloc _videoPageBloc;
  List<File> thumbnails = [];

  @override
  void initState() {
    super.initState();
    _videoPageBloc = di<VideoPageBloc>();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // setState(() {
      _getVideosThumbnail();
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _videoPageBloc,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: Container(
          // color: Colors.blueGrey,
          padding: const EdgeInsets.symmetric(
            horizontal: MarginKeys.commonHorzontalAndVerticalPadding,
            vertical: MarginKeys.commonHorzontalAndVerticalPadding,
          ),
          child: widget.filesList.isNotEmpty
              ? thumbnails.isNotEmpty
                  ? GridViewBuilder(
                      itemCount: widget.filesList.length,
                      isVideoView: true,
                      videoFiles: widget.filesList,
                      thumbnails: thumbnails,
                      onTapCallback: _navigateVideoDetailView,
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    )
              : Center(
                  child: Text(
                    'No Video found!',
                    style: TextStyles.bodyText.copyWith(color: Colors.white),
                  ),
                ),
        ));
      },
    );
  }

  Future _getVideosThumbnail() async {
    for (File item in widget.filesList) {
      // thumbnails.add(item.path);
      final thumbnail = await VideoThumbnail.thumbnailFile(video: item.path);
      thumbnails.add(File(thumbnail ?? ''));
    }
    setState(() {});
  }

  _navigateVideoDetailView(int index) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => VideoDetailPage(
              bloc: _videoPageBloc,
              video: widget.filesList[index],
            )));
  }
}
