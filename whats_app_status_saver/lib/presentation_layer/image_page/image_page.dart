import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_layer/image_bloc/main_page_bloc.dart';
import '../../injection/injection_container.dart';
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
  Widget build(BuildContext context) {
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
  }
}
