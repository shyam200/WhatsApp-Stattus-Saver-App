import 'package:flutter/material.dart';

import '../../../business_layer/main_page_bloc/main_page_bloc.dart';
import '../../../business_layer/main_page_bloc/main_page_event.dart';
import '../../../core/local_storage/shared_preference_manager.dart';
import '../../../injection/injection_container.dart';
import '../../../resources/dimension_keys.dart';
import '../../../resources/images.dart';
import '../../../resources/preference_keys.dart';
import '../../../resources/string_keys.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/ws_colors.dart';

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
  late SharedPreferenceManager sharedPreferenceManager;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    sharedPreferenceManager = di<SharedPreferenceManager>();
    _isDarkMode = sharedPreferenceManager.getBool(PrefKeys.isDarkMode,
        defaultValue: false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        // width: MediaQuery.of(context).size.width * 0.6,
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        _buildDrawerHeader(),
        _buildDrawerItems(
            title: StringKeys.darkModeText,
            icon: Icons.dark_mode,
            onTap: _onTapDarkMode),
        // _buildDrawerItems(title: 'Share App', icon: Icons.share, onTap: () {}),
      ],
    ));
  }

  DrawerHeader _buildDrawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
          color: _isDarkMode ? Colors.grey[800] : WSColors.darkGreenColor),
      child: Align(
          alignment: Alignment.center,
          child: SizedBox(
              height: DimensionKeys.menuBarImgDimensioin,
              width: DimensionKeys.menuBarImgDimensioin,
              child: Image.asset(
                Images.wsSaverDrawerImg,
                fit: BoxFit.contain,
              ))),
    );
  }

  _buildDrawerItems({
    required String title,
    required IconData icon,
    required Function() onTap,
  }) {
    return ListTile(
      leading: Icon(icon,
          color: _isDarkMode ? Colors.white : WSColors.lightGreenColor),
      title: Text(
        title,
        style: appTextTheme(context)
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
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
    widget.bloc.add(ToggleDarkThemeModeEvent(_isDarkMode));
  }
}
