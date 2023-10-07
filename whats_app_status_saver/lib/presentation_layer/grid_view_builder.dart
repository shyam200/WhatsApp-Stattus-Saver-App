import 'dart:io';

import 'package:flutter/material.dart';
import '../core/local_storage/shared_preference_manager.dart';
import '../injection/injection_container.dart';
import '../resources/preference_keys.dart';
import '../resources/ws_colors.dart';

import '../resources/dimension_keys.dart';
import '../resources/margin_keys.dart';

class GridViewBuilder extends StatelessWidget {
  final int itemCount;
  final bool isVideoView;
  final List? filesPath;
  final List<File> thumbnails;
  final List<File>? videoFiles;
  final Function(int)? onTapCallback;

  const GridViewBuilder(
      {Key? key,
      required this.itemCount,
      this.isVideoView = false,
      this.filesPath,
      this.onTapCallback,
      this.thumbnails = const [],
      this.videoFiles = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return filesPath != null || thumbnails.isNotEmpty
        ? GridView.builder(
            itemCount: isVideoView ? thumbnails.length : filesPath?.length ?? 0,
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
                    child:
                        // Image.memory(filesPath![index])
                        Image.file(
                      isVideoView ? thumbnails[index] : filesPath![index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            })
        : const SizedBox();
  }

  Color _getOutlineColor() {
    return di<SharedPreferenceManager>().getBool(PrefKeys.isDarkMode)
        ? WSColors.whiteMaterialColor.shade700
        : WSColors.lightGreenColor;
  }
}
