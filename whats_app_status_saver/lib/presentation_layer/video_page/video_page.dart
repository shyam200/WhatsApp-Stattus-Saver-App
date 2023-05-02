import 'dart:io';

import 'package:flutter/material.dart';

import '../../business_layer/image_bloc/main_page_bloc.dart';
import '../../resources/margin_keys.dart';
import '../grid_view_builder.dart';

class Videopage extends StatefulWidget {
  final MainPageBloc bloc;
  final List<File> filesList;
  const Videopage({super.key, required this.bloc, required this.filesList});

  @override
  State<Videopage> createState() => _VideopageState();
}

class _VideopageState extends State<Videopage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        padding: const EdgeInsets.symmetric(
          horizontal: MarginKeys.commonHorzontalAndVerticalPadding,
        ),
        child: GridViewBuilder(
          bloc: widget.bloc,
          itemCount: 5,
          isVideoView: true,
        ),
      ),
    );
  }
}
