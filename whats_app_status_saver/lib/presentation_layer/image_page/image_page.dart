import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_status_saver/business_layer/image_bloc/main_page_event.dart';
import 'package:whats_app_status_saver/business_layer/image_bloc/main_page_state.dart';

import '../../business_layer/image_bloc/main_page_bloc.dart';
import '../../resources/margin_keys.dart';
import '../grid_view_builder.dart';

class ImagePage extends StatefulWidget {
  final MainPageBloc bloc;
  const ImagePage({super.key, required this.bloc});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(GetGalleryPermissionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: widget.bloc,
      listener: (context, state) {
        if (state is GalleryPermissionGrantedState) {
          widget.bloc.add(GetWhatsAppStatusesEvent());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: MarginKeys.commonHorizontalPadding,
            ),
            child: GridViewBuilder(
              bloc: widget.bloc,
              itemCount: 8,
            ),
          ),
        );
      },
    );
  }
}
