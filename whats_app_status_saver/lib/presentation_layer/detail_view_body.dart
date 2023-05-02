import 'dart:developer';

import 'package:flutter/material.dart';

import '../resources/margin_keys.dart';

class ImageVideoDetailViewBody extends StatefulWidget {
  final bool isVideoDetailView;
  const ImageVideoDetailViewBody({super.key, this.isVideoDetailView = false});

  @override
  State<ImageVideoDetailViewBody> createState() =>
      _ImageVideoDetailViewBodyState();
}

class _ImageVideoDetailViewBodyState extends State<ImageVideoDetailViewBody> {
  @override
  Widget build(BuildContext context) {
    print('${widget.isVideoDetailView}');
    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: MarginKeys.commonHorzontalAndVerticalPadding,
            vertical: MarginKeys.commonHorzontalAndVerticalPadding),
        child: Column(
          children: [
            const SizedBox(height: 300, child: Placeholder()),
            const Spacer(),
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildIconButton(
                      icon: Icons.download,
                      onTap: () {
                        log('download');
                      }),
                  !widget.isVideoDetailView
                      ? _buildIconButton(
                          icon: Icons.picture_as_pdf,
                          onTap: () {
                            log('print pdf');
                          })
                      : const SizedBox(),
                  _buildIconButton(
                      icon: Icons.share,
                      onTap: () {
                        log('share');
                      }),
                ],
              ),
            )
          ],
        ));
  }

  _buildIconButton({required IconData icon, required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 60,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.tealAccent,
            border: Border.all(color: Colors.grey, width: 0.5),
          ),
          child: Icon(icon),
        ),
      ),
    );
  }
}
