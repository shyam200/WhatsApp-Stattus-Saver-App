import 'package:flutter/material.dart';

import '../../../business_layer/main_page_bloc/main_page_bloc.dart';
import '../../../business_layer/main_page_bloc/main_page_event.dart';
import '../../../core/singleton/ws_app_data.dart';
import '../../../core/widgets/ws_common_dialog.dart';
import '../../../injection/injection_container.dart';
import '../../../resources/dimension_keys.dart';
import '../../../resources/images.dart';
import '../../../resources/string_keys.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/ws_colors.dart';

class WSDrawer extends StatefulWidget {
  final MainPageBloc bloc;
  const WSDrawer({
    super.key,
    required this.bloc,
  });

  @override
  State<WSDrawer> createState() => _WSDrawerState();
}

class _WSDrawerState extends State<WSDrawer> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _isDarkMode = di<WsAppData>().isDarkMode;
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
            trailingWidget: SizedBox(
                width: 50,
                height: 30,
                child: Switch(
                    value: _isDarkMode,
                    onChanged: (_) {
                      _toggleSwitch();
                    })),
            onTap: _onTapDarkMode),
        _buildDrawerItems(
            title: StringKeys.howToUse,
            icon: Icons.info,
            onTap: _onHowToUseTap),
        _buildDrawerItems(
            title: StringKeys.shareAppText,
            icon: Icons.share,
            onTap: _onShareAppTap),
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
    Widget? trailingWidget,
  }) {
    return ListTile(
        leading: Icon(icon,
            color: _isDarkMode ? Colors.white : WSColors.lightGreenColor),
        title: Text(
          title,
          style: appTextTheme(context)
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        onTap: onTap,
        trailing: trailingWidget);
  }

  _onTapDarkMode() {
    _toggleSwitch();
  }

  _onHowToUseTap() {
    showDialog(
      context: context,
      builder: (_) => WSCommonDialog(
        bodyColor:
            _isDarkMode ? const Color.fromARGB(255, 54, 53, 53) : Colors.white,
        headingColor: _isDarkMode ? Colors.white : Colors.black,
        headingText: StringKeys.howToUse,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoDialogText(
              count: '➊',
              text: StringKeys.howToUseBd1,
            ),
            _buildInfoDialogText(
              count: '➋',
              text: StringKeys.howToUseBd2,
            ),
            _buildInfoDialogText(
              count: '➌',
              text: StringKeys.howToUseBd3,
            ),
          ],
        ),
      ),
    );
  }

  Text _buildInfoDialogText({
    required String count,
    required String text,
  }) {
    return Text(
      '$count $text',
      style: appTextTheme(context)
          .bodyLarge!
          .copyWith(fontWeight: FontWeight.w600),
    );
  }

  _toggleSwitch() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    widget.bloc.add(ToggleDarkThemeModeEvent(_isDarkMode));
  }

  _onShareAppTap() {
    widget.bloc.add(ShareWsAPPEvent());
  }
}
