import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_layer/image_bloc/main_page_bloc.dart';
import '../../business_layer/image_bloc/main_page_state.dart';
import '../../resources/margin_keys.dart';
import '../grid_view_builder.dart';

class ImagePage extends StatefulWidget {
  final MainPageBloc bloc;
  final List<File> imagesList;
  const ImagePage({super.key, required this.bloc, required this.imagesList});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  List<File>? filesPath;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: widget.bloc,
      listener: (context, state) {
        if (state is GalleryFilesLoadedState) {
          // widget.bloc.add(GetWhatsAppStatusesEvent());
          // filesPath = state.imagesList;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is MainPageLoadingState
              ? _buildLoadingIndicator()
              : _buildImageBody(),
        );
      },
    );
  }

  _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.teal,
      ),
    );
  }

  _buildImageBody() {
    return widget.imagesList.isNotEmpty
        ? SafeArea(
            child: Container(
              color: Colors.grey,
              padding: const EdgeInsets.symmetric(
                horizontal: MarginKeys.commonHorzontalAndVerticalPadding,
                vertical: MarginKeys.commonHorzontalAndVerticalPadding,
              ),
              child: GridViewBuilder(
                bloc: widget.bloc,
                itemCount: widget.imagesList.length,
                filesPath: widget.imagesList,
              ),
            ),
          )
        : const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MarginKeys.commonHorzontalAndVerticalPadding),
              child: Text(
                  'No Status Images found please ensure that you have wathced status or you have any status present on whatsapp'),
            ),
          );
  }
}
