import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../business_layer/image_page_bloc.dart/image_page_bloc.dart';
import '../../business_layer/image_page_bloc.dart/image_page_event.dart';
import '../../business_layer/image_page_bloc.dart/image_page_state.dart';
import '../../resources/common_constants.dart';
import '../../resources/string_keys.dart';
import '../ws_detail_view_buttons.dart';

class ImageDetailPage extends StatefulWidget {
  final File image;
  final int index;
  final List imageList;
  final ImagePageBloc bloc;
  const ImageDetailPage(
      {super.key,
      required this.index,
      required this.imageList,
      required this.image,
      required this.bloc});

  @override
  State<ImageDetailPage> createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage> {
  late File _currentImage;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentImage = widget.image;
    _currentIndex = widget.index;
  }

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
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Stack(children: [
              _buildImage(),
              _buildCloseButton(),
              _buildButtons(),
            ]),
          ),
        );
      },
    );
  }

  Widget _buildCloseButton() {
    return Positioned(
      left: 10,
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back),
        color: Colors.white,
        iconSize: 32,
      ),
    );
  }

  Positioned _buildButtons() {
    return Positioned.fill(
      bottom: 20,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: WSDetailViewButtons(
          onDownloadTap: _onDownloadTap,
          onShareTap: _onShareTap,
        ),
      ),
    );
  }

  Center _buildImage() {
    return Center(
      child: SwipeTo(
        animationDuration: const Duration(milliseconds: 20),
        onRightSwipe: (details) {
          if (_currentIndex > 0) {
            setState(() {
              _currentImage = widget.imageList[_currentIndex - 1];
              _currentIndex -= 1;
            });
          }
        },
        onLeftSwipe: (details) {
          if (_currentIndex < widget.imageList.length - 1) {
            setState(() {
              _currentImage = widget.imageList[_currentIndex + 1];
              _currentIndex += 1;
            });
          }
        },
        child: Image.file(_currentImage),
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
