import 'package:flutter/material.dart';

import '../resources/margin_keys.dart';

class WSDetailViewButtons extends StatelessWidget {
  final Function() onDownloadTap;
  final Function() onWishlistTap;
  final Function() onShareTap;

  const WSDetailViewButtons({
    super.key,
    required this.onDownloadTap,
    required this.onWishlistTap,
    required this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
            // horizontal: MarginKeys.commonHorzontalAndVerticalPadding,
            bottom: MarginKeys.commonHorzontalAndVerticalPadding),
        child: _buildButtons());
  }

  _buildButtons() {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconButton(icon: Icons.download, onTap: onDownloadTap
              // () {
              //   widget.bloc.add(GetStatusDownloadEvent(
              //       url: widget.detailViewbody.path,
              //       isVideoDetailView: widget.isVideoDetailView));
              // }
              ),
          _buildIconButton(icon: Icons.favorite_border, onTap: onWishlistTap
              //  () {
              //   widget.bloc.add(GetStatusWishlistEvent());
              // }
              ),
          _buildIconButton(icon: Icons.share, onTap: onShareTap
              // () {
              //   widget.bloc.add(GetStatusShareEvent());
              // }
              ),
        ],
      ),
    );
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
