import 'package:flutter/material.dart';

import '../../../resources/text_styles.dart';

class WSDrawer extends StatelessWidget {
  const WSDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: MediaQuery.of(context).size.width * 0.6,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildDrawerHeader(),
            _buildDrawerItems(
                title: 'Dark Mode', icon: Icons.dark_mode, onTap: () {}),
            _buildDrawerItems(
                title: 'Share App', icon: Icons.share, onTap: () {}),
          ],
        ));
  }

  DrawerHeader _buildDrawerHeader() {
    return DrawerHeader(
      decoration: const BoxDecoration(color: Colors.teal),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Ws Saver Menu',
          style: TextStyles.headingText.copyWith(fontSize: 24),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  ListTile _buildDrawerItems({
    required String title,
    required IconData icon,
    required Function() onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
