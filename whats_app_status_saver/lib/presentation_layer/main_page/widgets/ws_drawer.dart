import 'package:flutter/material.dart';
import 'package:whats_app_status_saver/business_layer/main_page_bloc/main_page_bloc.dart';
import 'package:whats_app_status_saver/injection/injection_container.dart';

import '../../../business_layer/main_page_bloc/main_page_event.dart';
import '../../../resources/text_styles.dart';

class WSDrawer extends StatefulWidget {
  final MainPageBloc bloc;
  const WSDrawer({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  State<WSDrawer> createState() => _WSDrawerState();
}

class _WSDrawerState extends State<WSDrawer> {
  bool _isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
        // width: MediaQuery.of(context).size.width * 0.6,
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        _buildDrawerHeader(),
        _buildDrawerItems(
            title: 'Dark Mode', icon: Icons.dark_mode, onTap: _onTapDarkMode),
        // _buildDrawerItems(title: 'Share App', icon: Icons.share, onTap: () {}),
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

  _buildDrawerItems({
    required String title,
    required IconData icon,
    required Function() onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
      trailing: SizedBox(
          width: 50,
          height: 30,
          child: Switch(
              value: _isDarkMode,
              onChanged: (_) {
                _toggleSwitch();
              })),
    );
  }

  //  return ListTile(
  _onTapDarkMode() {
    // Navigator.of(context).pop();
    _toggleSwitch();
  }

  _toggleSwitch() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    di<MainPageBloc>().add(ToggleDarkThemeModeEvent(_isDarkMode));
  }
}
