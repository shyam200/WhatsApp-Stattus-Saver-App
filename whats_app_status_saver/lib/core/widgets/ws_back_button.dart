import 'package:flutter/material.dart';
import 'package:whats_app_status_saver/resources/dimension_keys.dart';

class WsBackButton extends StatelessWidget {
  const WsBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        iconSize: DimensionKeys.iconSize,
      ),
    );
  }
}
