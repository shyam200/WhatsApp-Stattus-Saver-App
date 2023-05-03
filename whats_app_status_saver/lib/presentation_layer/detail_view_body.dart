import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../resources/margin_keys.dart';
import 'video_page/ws_video_player.dart';

class ImageVideoDetailViewBody extends StatefulWidget {
  final bool isVideoDetailView;
  final File detailViewbody;
  const ImageVideoDetailViewBody(
      {super.key,
      this.isVideoDetailView = false,
      required this.detailViewbody});

  @override
  State<ImageVideoDetailViewBody> createState() =>
      _ImageVideoDetailViewBodyState();
}

class _ImageVideoDetailViewBodyState extends State<ImageVideoDetailViewBody> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    if (widget.isVideoDetailView) {
      _videoPlayerController = VideoPlayerController.file(widget.detailViewbody)
        ..initialize().then((value) {
          setState(() {});
          // _videoPlayerController.play();
        });
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
            // horizontal: MarginKeys.commonHorzontalAndVerticalPadding,
            bottom: MarginKeys.commonHorzontalAndVerticalPadding),
        child: Column(
          children: [
            widget.isVideoDetailView
                ? _buildVideoPlayerBody()
                : _buildImageBody(),
            const Spacer(),
            _buildButtons()
          ],
        ));
  }

  _buildImageBody() {
    return SizedBox(
      height: 400,
      child: Image.file(
        widget.detailViewbody,
        fit: BoxFit.fill,
        // filterQuality: FilterQuality.high,
      ),
    );
  }

  _buildButtons() {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconButton(
              icon: Icons.download,
              onTap: () {
                log('download');
              }),
          _buildIconButton(
              icon: Icons.favorite_border,
              onTap: () {
                log('favourites');
              }),
          _buildIconButton(
              icon: Icons.share,
              onTap: () {
                log('share');
              }),
        ],
      ),
    );
  }

  _buildIconButton({required IconData icon, required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 60,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.tealAccent,
            border: Border.all(color: Colors.grey, width: 0.5),
          ),
          child: Icon(icon),
        ),
      ),
    );
  }

  _buildVideoPlayerBody() {
    return _videoPlayerController.value.isInitialized
        ? WsVideoPlayer(videoPlayerController: _videoPlayerController)
        : const SizedBox();
  }
}
