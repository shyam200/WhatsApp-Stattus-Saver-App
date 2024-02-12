import 'package:flutter/material.dart';

class WSDetailViewButtons extends StatefulWidget {
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
  State<WSDetailViewButtons> createState() => _WSDetailViewButtonsState();
}

class _WSDetailViewButtonsState extends State<WSDetailViewButtons> {
  @override
  Widget build(BuildContext context) {
    return _buildButtons();
  }

  _buildButtons() {
    return SafeArea(
      child: Row(
        children: [
          _buildIconButton(icon: Icons.download, onTap: widget.onDownloadTap),
          _buildIconButton(icon: Icons.share, onTap: widget.onShareTap),
        ],
      ),
    );
  }

  _buildIconButton({required IconData icon, required Function() onTap}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          height: 60,
          width: 80,
          decoration: BoxDecoration(
            color: Theme.of(context).buttonTheme.colorScheme?.background,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey, width: 0.5),
            // boxShadow: const [
            //   BoxShadow(
            //       color: Colors.grey, //New
            //       blurRadius: 25.0,
            //       offset: Offset(0, 0))
            // ],
          ),
          child: IconButton(
            icon: Icon(icon),
            // color: Colors.green,
            iconSize: 34,
            // elevation: 10.0,
            // borderRadius: BorderRadius.circular(16),
            onPressed: onTap,
          ),
        ),
      ),
    );
  }
}
