import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_layer/image_bloc/main_page_bloc.dart';
import '../../business_layer/image_bloc/main_page_state.dart';
import '../../injection/injection_container.dart';
import '../detail_view_body.dart';

class ImageDetailPage extends StatefulWidget {
  final MainPageBloc bloc;
  final File image;
  const ImageDetailPage({super.key, required this.bloc, required this.image});

  @override
  State<ImageDetailPage> createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage> {
  late MainPageBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = di<MainPageBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _bloc,
      listener: (context, state) {
        if (state is MainPageLoadingState) {
          log("reached to destiny");
          print('inside page');
        } else if (state is MainPageDataLoadedState) {
          print('inside data loaded state');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: ImageVideoDetailViewBody(
            detailViewbody: widget.image,
          ),
        );
      },
    );
  }
}
