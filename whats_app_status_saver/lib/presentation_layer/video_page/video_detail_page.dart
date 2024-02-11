import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../business_layer/video_page_bloc.dart/video_page_bloc.dart';
import '../../business_layer/video_page_bloc.dart/video_page_event.dart';
import '../../business_layer/video_page_bloc.dart/video_page_state.dart';
import '../../core/widgets/ws_loader.dart';
import '../../resources/common_constants.dart';
import '../../resources/string_keys.dart';
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
        // setState(() {});
        // _videoPlayerController.play();
        widget.bloc.add(StatusVideoInitialiseEvent());
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
            content: Text(StringKeys.videoSuccessTxt),
            duration:
                Duration(seconds: CommonConstants.snackBarDurationSeconds),
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: Stack(children: [
                _buildBody(),
                _buildBackBtn(),
                if (state is VideoPageLoadingState) const WsLoader()
              ]),
            ));
      },
    );
  }

  Column _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _buildVideoPlayerBody(),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: WSDetailViewButtons(
            onDownloadTap: _onDownloadTap,
            onShareTap: _onShareTap,
          ),
        )
      ],
    );
  }

  IconButton _buildBackBtn() {
    return IconButton(
        color: Colors.white,
        onPressed: () {
          Navigator.of(context).pop();
        },
        iconSize: 34,
        icon: const Icon(Icons.arrow_back));
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

  _onShareTap() {
    widget.bloc.add(StatusVideoShareEvent(widget.video));
  }
}
