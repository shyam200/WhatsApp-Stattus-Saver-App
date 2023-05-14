import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_layer/main_page_bloc/main_page_bloc.dart';
import '../../business_layer/main_page_bloc/main_page_state.dart';
import 'package:whats_app_status_saver/injection/injection_container.dart';

import '../splash_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDarkModeTheme = false;
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
          theme: _isDarkModeTheme
              ? ThemeData.dark()
              : ThemeData
                  .light(), //WSAppTheme.themeData(_isDarkModeTheme, context),
          // ThemeData(

          //     // primarySwatch: Colors.teal,
          //     ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
