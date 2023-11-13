import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_layer/main_page_bloc/main_page_bloc.dart';
import '../../business_layer/main_page_bloc/main_page_state.dart';
import '../../core/app_theme/app_theme.dart';
import '../../core/local_storage/shared_preference_manager.dart';
import '../../injection/injection_container.dart';
import '../../resources/preference_keys.dart';
import '../../resources/string_keys.dart';
import '../../resources/ws_colors.dart';
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

    _isDarkModeTheme = di<SharedPreferenceManager>()
        .getBool(PrefKeys.isDarkMode, defaultValue: false);
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
          title: StringKeys.appTitleText,
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
