import 'dart:io';

import 'package:flutter/material.dart';

import '../core/singleton/ws_app_data.dart';
import '../injection/injection_container.dart';
import '../resources/dimension_keys.dart';
import '../resources/margin_keys.dart';
import '../resources/ws_colors.dart';

class GridViewBuilder extends StatelessWidget {
  final int itemCount;
  final bool isVideoView;
  final List? filesPath;
  final List<File>? thumbnails;

  final Function(int)? onTapCallback;

  const GridViewBuilder({
    super.key,
    required this.itemCount,
    this.isVideoView = false,
    this.filesPath,
    this.onTapCallback,
    this.thumbnails = const [],
  });

  @override
  Widget build(BuildContext context) {
    return filesPath != null || (thumbnails != null && thumbnails!.isNotEmpty)
        ? GridView.builder(
            itemCount:
                isVideoView ? thumbnails?.length : filesPath?.length ?? 0,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: MarginKeys.gridMainAxisSpacing,
              crossAxisSpacing: MarginKeys.gridCrossAxisSpacing,
            ),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: _getOutlineColor(),
                      width: 8,
                    )),
                child: InkWell(
                  onTap: () {
                    onTapCallback!(index);
                  },
                  child: SizedBox(
                    width: DimensionKeys.imageWeight,
                    height: DimensionKeys.imageHeight,
                    child: Image.file(
                      isVideoView ? thumbnails![index] : filesPath![index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            })
        : const SizedBox();
  }

  Color _getOutlineColor() {
    return di<WsAppData>().isDarkMode
        ? WSColors.whiteMaterialColor.shade700
        : WSColors.lightGreenColor;
  }
}
