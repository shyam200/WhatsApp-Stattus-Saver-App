import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:whats_app_status_saver/resources/common_constants.dart';

import '../../business_layer/video_page_bloc.dart/video_page_bloc.dart';
import '../../business_layer/video_page_bloc.dart/video_page_event.dart';
import '../../business_layer/video_page_bloc.dart/video_page_state.dart';
import '../../resources/margin_keys.dart';
import '../ws_detail_view_buttons.dart';
import 'ws_video_player.dart';

class VideoDetailPage extends StatefulWidget {
  final File video;
  final VideoPageBloc bloc;
  const VideoDetailPage({super.key, required this.video, required this.bloc});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.file(widget.video)
      ..initialize().then((value) {
        setState(() {});
        // _videoPlayerController.play();
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: widget.bloc,
      listener: (context, state) {
        if (state is GalleryVideoDownloadedSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Video Saved Successfully!'),
            duration:
                Duration(seconds: CommonConstants.snackBarDurationSeconds),
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(),
            body: Container(
                padding: const EdgeInsets.only(
                    bottom: MarginKeys.commonHorzontalAndVerticalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildVideoPlayerBody(),
                    const Spacer(),
                    WSDetailViewButtons(
                      onDownloadTap: _onDownloadTap,
                      onShareTap: _onShareTap,
                    )
                  ],
                )));
      },
    );
  }

  _buildVideoPlayerBody() {
    return _videoPlayerController.value.isInitialized
        ? WsVideoPlayer(videoPlayerController: _videoPlayerController)
        : const SizedBox();
  }

  _onDownloadTap() {
    widget.bloc.add(GetStatusVideoDownloadEvent(
      url: widget.video.path,
    ));
  }

  _onWishlistTap() {}

  _onShareTap() {
    widget.bloc.add(StatusVideoShareEvent(widget.video));
  }
}
