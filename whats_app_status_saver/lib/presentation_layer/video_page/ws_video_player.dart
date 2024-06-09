import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WsVideoPlayer extends StatefulWidget {
  const WsVideoPlayer({
    super.key,
    required VideoPlayerController videoPlayerController,
  }) : _videoPlayerController = videoPlayerController;

  final VideoPlayerController _videoPlayerController;

  @override
  State<WsVideoPlayer> createState() => _WsVideoPlayerState();
}

class _WsVideoPlayerState extends State<WsVideoPlayer> {
  late ChewieController _chewieController;
  @override
  void initState() {
    super.initState();

    _chewieController = ChewieController(
        videoPlayerController: widget._videoPlayerController,
        looping: true,
        autoPlay: true,
        aspectRatio: 0.5);
  }

  @override
  void dispose() {
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewieController,
    );
  }
}
