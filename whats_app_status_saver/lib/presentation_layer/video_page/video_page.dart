import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_layer/video_page_bloc/video_page_bloc.dart';
import '../../business_layer/video_page_bloc/video_page_event.dart';
import '../../business_layer/video_page_bloc/video_page_state.dart';
import '../../core/widgets/ws_loader.dart';
import '../../injection/injection_container.dart';
import '../../resources/margin_keys.dart';
import '../../resources/string_keys.dart';
import '../../resources/text_styles.dart';
import '../grid_view_builder.dart';
import 'video_detail_page.dart';

class Videopage extends StatefulWidget {
  final List<File> filesList;
  const Videopage({super.key, required this.filesList});

  @override
  State<Videopage> createState() => _VideopageState();
}

class _VideopageState extends State<Videopage> {
  late VideoPageBloc _videoPageBloc;
  List<File> thumbnails = [];
  bool isThumbnailsEmpty = false;

  @override
  void initState() {
    super.initState();
    _videoPageBloc = di<VideoPageBloc>();
    _videoPageBloc.add(GenerateVideosThumbnailEvent(widget.filesList));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _videoPageBloc,
      listener: (context, state) {
        if (state is VideosThumbnailLoadedState) {
          thumbnails = state.videosThumbnail;
          isThumbnailsEmpty = thumbnails.isEmpty ? true : false;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(children: [
            Container(
              // color: Colors.blueGrey,
              padding: const EdgeInsets.symmetric(
                horizontal: MarginKeys.commonHorzontalAndVerticalPadding,
                vertical: MarginKeys.commonHorzontalAndVerticalPadding,
              ),
              child: !isThumbnailsEmpty
                  ? GridViewBuilder(
                      itemCount: widget.filesList.length,
                      isVideoView: true,
                      videoFiles: widget.filesList,
                      thumbnails: thumbnails,
                      onTapCallback: _navigateVideoDetailView,
                    )
                  : Center(
                      child: Text(StringKeys.noVideosFoundTxt,
                          style: appTextTheme(context).bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
            ),
            state is VideoPageLoadingState ? const WsLoader() : const SizedBox()
          ]),
        );
      },
    );
  }

  _navigateVideoDetailView(int index) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => VideoDetailPage(
              bloc: _videoPageBloc,
              video: widget.filesList[index],
            )));
  }
}
