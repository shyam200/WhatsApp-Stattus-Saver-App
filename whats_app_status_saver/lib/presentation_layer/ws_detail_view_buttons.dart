import 'package:flutter/material.dart';

class WSDetailViewButtons extends StatelessWidget {
  final Function() onDownloadTap;
  final Function()? onWishlistTap;
  final Function() onShareTap;

  const WSDetailViewButtons({
    super.key,
    required this.onDownloadTap,
    this.onWishlistTap,
    required this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    return _buildButtons();
  }

  _buildButtons() {
    return SafeArea(
      child: Row(
        children: [
          _buildIconButton(icon: Icons.download, onTap: onDownloadTap),
          // _buildIconButton(
          //     icon: Icons.favorite_border, onTap: onWishlistTap ?? () {}),
          _buildIconButton(icon: Icons.share, onTap: onShareTap),
        ],
      ),
    );
  }

  _buildIconButton({required IconData icon, required Function() onTap}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: InkWell(
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
        ),
      ),
    );
  }
}
