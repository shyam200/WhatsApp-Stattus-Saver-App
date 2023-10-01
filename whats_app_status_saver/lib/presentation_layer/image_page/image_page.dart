import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../resources/string_keys.dart';
import '../../resources/text_styles.dart';

import '../../business_layer/image_page_bloc.dart/image_page_bloc.dart';
import '../../injection/injection_container.dart';
import '../../resources/margin_keys.dart';
import '../grid_view_builder.dart';
import 'image_detail_page.dart';

class ImagePage extends StatefulWidget {
  final List imagesList;
  const ImagePage({super.key, required this.imagesList});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  late ImagePageBloc _imagePageBloc;
  List<File>? filesPath;
  @override
  void initState() {
    super.initState();
    _imagePageBloc = di<ImagePageBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _imagePageBloc,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: _buildImageBody(),
        );
      },
    );
  }

  _buildImageBody() {
    return widget.imagesList.isNotEmpty
        ? SafeArea(
            child: Container(
              // color: Colors.blueGrey,
              padding: const EdgeInsets.symmetric(
                horizontal: MarginKeys.commonHorzontalAndVerticalPadding,
                vertical: MarginKeys.commonHorzontalAndVerticalPadding,
              ),
              child: GridViewBuilder(
                  itemCount: widget.imagesList.length,
                  filesPath: widget.imagesList,
                  onTapCallback: _navigateImageDetailView),
            ),
          )
        : const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MarginKeys.commonHorzontalAndVerticalPadding),
              child: Text(StringKeys.imageNotFoundTxt,
                  style: TextStyles.bodyTextBold),
            ),
          );
  }

  _navigateImageDetailView(int index) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => ImageDetailPage(
              bloc: _imagePageBloc,
              image: widget.imagesList[index],
            )));
  }
}
