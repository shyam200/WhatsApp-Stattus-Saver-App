import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WsVideoPlayer extends StatefulWidget {
  const WsVideoPlayer({
    Key? key,
    required VideoPlayerController videoPlayerController,
  })  : _videoPlayerController = videoPlayerController,
        super(key: key);

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
        aspectRatio: 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 400,
          width: double.infinity,
          child: Chewie(
            controller: _chewieController,
          ),
        ),
      ],
    );
  }
}
