import 'package:flutter/material.dart';

import '../detail_view_body.dart';

class VideoDetailPage extends StatefulWidget {
  const VideoDetailPage({super.key});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const ImageVideoDetailViewBody(
        isVideoDetailView: true,
      ),
    );
  }
}
