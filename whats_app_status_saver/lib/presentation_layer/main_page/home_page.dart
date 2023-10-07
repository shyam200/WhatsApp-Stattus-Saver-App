import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_status_saver/core/local_storage/shared_preference_manager.dart';
import 'package:whats_app_status_saver/resources/preference_keys.dart';
import 'package:whats_app_status_saver/resources/ws_colors.dart';

import '../../business_layer/main_page_bloc/main_page_bloc.dart';
import '../../business_layer/main_page_bloc/main_page_state.dart';
import '../../core/app_theme/app_theme.dart';
import '../../injection/injection_container.dart';
import 'main_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDarkModeTheme = false;

  @override
  void initState() {
    super.initState();

    _isDarkModeTheme =
        di<SharedPreferenceManager>().getBool(PrefKeys.isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: di<MainPageBloc>(),
      listener: (context, state) {
        if (state is ToggleDarkThemeModeState) {
          _isDarkModeTheme = state.isDarkMode;
        }
      },
      builder: (context, state) {
        return MaterialApp(
          title: 'Whats App Status Saver',
          debugShowCheckedModeBanner: false,
          theme:
              // _isDarkModeTheme ? ThemeData.dark() : ThemeData.light(),
              WSAppTheme.themeData(_isDarkModeTheme, context),
          color: WSColors.lightGreenColor,
          home: const Mainpage(),
        );
      },
    );
  }
}
