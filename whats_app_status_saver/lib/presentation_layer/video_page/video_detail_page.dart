import 'dart:io';

import 'package:flutter/material.dart';

import '../detail_view_body.dart';

class VideoDetailPage extends StatefulWidget {
  final File video;
  const VideoDetailPage({super.key, required this.video});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ImageVideoDetailViewBody(
        detailViewbody: widget.video,
        isVideoDetailView: true,
      ),
    );
  }
}
