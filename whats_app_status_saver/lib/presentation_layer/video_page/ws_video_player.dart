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
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 400,
          child: VideoPlayer(widget._videoPlayerController),
        ),
        SizedBox(
          height: 8,
          child: VideoProgressIndicator(
            widget._videoPlayerController,
            allowScrubbing: true,
            padding: EdgeInsets.zero,
            colors: const VideoProgressColors(
              playedColor: Colors.green,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            height: 60,
            width: double.infinity,
            color: widget._videoPlayerController.value.isPlaying
                ? Colors.redAccent
                : Colors.tealAccent,
            child: TextButton(
                onPressed: () {
                  setState(() {
                    widget._videoPlayerController.value.isPlaying
                        ? widget._videoPlayerController.pause()
                        : widget._videoPlayerController.play();
                  });
                },
                child: widget._videoPlayerController.value.isPlaying
                    ? const Icon(
                        Icons.pause,
                        color: Colors.white,
                        size: 40,
                      )
                    : const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 40,
                      )),
          ),
        )
      ],
    );
  }
}
