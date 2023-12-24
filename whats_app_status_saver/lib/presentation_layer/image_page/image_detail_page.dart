import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_layer/image_page_bloc.dart/image_page_bloc.dart';
import '../../business_layer/image_page_bloc.dart/image_page_event.dart';
import '../../business_layer/image_page_bloc.dart/image_page_state.dart';
import '../../resources/common_constants.dart';
import '../../resources/margin_keys.dart';
import '../../resources/string_keys.dart';
import '../ws_detail_view_buttons.dart';

class ImageDetailPage extends StatefulWidget {
  final File image;
  final ImagePageBloc bloc;
  const ImageDetailPage({super.key, required this.image, required this.bloc});

  @override
  State<ImageDetailPage> createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: widget.bloc,
      listener: (context, state) {
        if (state is GalleryImageDownloadedSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(StringKeys.imageSuccessTxt),
            duration:
                Duration(seconds: CommonConstants.snackBarDurationSeconds),
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              toolbarHeight: 40,
              iconTheme: Theme.of(context)
                  .iconTheme
                  .copyWith(size: 30, color: Colors.white),
            ),
            body: Container(
                padding: const EdgeInsets.only(
                  top: MarginKeys.commonHorzontalAndVerticalPadding / 2,
                  bottom: MarginKeys.commonHorzontalAndVerticalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildImageBody(),
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

  _buildImageBody() {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 200,
      child: Image.file(
        widget.image,
        fit: BoxFit.contain,
      ),
    );
  }

  _onDownloadTap() {
    widget.bloc.add(StatusImageDownloadEvent(
      url: widget.image.path,
    ));
  }

  _onShareTap() {
    widget.bloc.add(StatusImageShareEvent(widget.image));
  }
}
