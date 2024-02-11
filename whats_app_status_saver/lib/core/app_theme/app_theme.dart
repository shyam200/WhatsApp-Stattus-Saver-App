import 'package:flutter/material.dart';

import '../../injection/injection_container.dart';
import '../../resources/preference_keys.dart';
import '../../resources/ws_colors.dart';
import '../local_storage/shared_preference_manager.dart';

class WSAppTheme {
  static ThemeData themeData() {
    bool isDarkTheme = di<SharedPreferenceManager>()
        .getBool(PrefKeys.isDarkMode, defaultValue: false);
    return ThemeData(
      primaryColor: isDarkTheme ? Colors.white : Colors.black,
      textTheme: TextTheme(
        displayMedium: TextStyle(
            color: isDarkTheme ? Colors.grey[300] : Colors.blueGrey[800],
            fontFamily: 'PlayfairDisplay',
            fontWeight: FontWeight.bold),
        bodySmall: TextStyle(
            color: isDarkTheme ? Colors.grey[200] : Colors.blueGrey[800],
            fontSize: 16,
            fontFamily: 'Montserrat'),
        bodyMedium: TextStyle(
            color: isDarkTheme ? Colors.grey[200] : Colors.blueGrey[800],
            fontSize: 18,
            fontFamily: 'Montserrat'),
        bodyLarge: TextStyle(
            color: isDarkTheme ? Colors.grey[300] : Colors.blueGrey[600],
            fontSize: 20,
            fontFamily: 'Montserrat'),
        //Use this for buttons label
        labelLarge: TextStyle(
            color: isDarkTheme ? Colors.grey[200] : Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat'),

        // displayMedium:
        //     TextStyle(color: isDarkTheme ? Colors.white : Colors.red),
      ),
      // primarySwatch: Colors.yellow,
      // indicatorColor:
      //     isDarkTheme ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
      // // buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),

      // hintColor:
      //     isDarkTheme ? const Color(0xff280C0B) : const Color(0xffEECED3),
      // highlightColor:
      //     isDarkTheme ? const Color(0xff372901) : const Color(0xffFCE192),
      // hoverColor:
      //     isDarkTheme ? const Color(0xff3A3A3B) : const Color(0xff4285F4),
      // focusColor:
      //     isDarkTheme ? const Color(0xff0B2512) : const Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      // cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,

      //App background color theme
      canvasColor: isDarkTheme ? Colors.grey[900] : Colors.grey[300],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      iconTheme:
          IconThemeData(color: isDarkTheme ? Colors.grey[800] : Colors.white),
      buttonTheme: ButtonThemeData(
        // buttonColor: Colors.blue,
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: isDarkTheme
              ? WSColors.whiteMaterialColor.shade700
              : WSColors.lightGreenColor,
          primarySwatch: isDarkTheme
              ? WSColors.whiteMaterialColor
              : WSColors.lightGreenMaterialColor,
          brightness: isDarkTheme ? Brightness.dark : Brightness.light,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              textStyle: const MaterialStatePropertyAll(
                  TextStyle(color: Colors.white)),
              backgroundColor: isDarkTheme
                  ? MaterialStatePropertyAll(Colors.blueGrey[400])
                  : MaterialStatePropertyAll(
                      WSColors.lightGreenMaterialColor.shade600))),

      //  Theme.of(context).buttonTheme.copyWith(
      //     colorScheme: isDarkTheme
      //         ? const ColorScheme.dark()
      //         : const ColorScheme.light()),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor:
            isDarkTheme ? Colors.grey[800] : WSColors.darkGreenColor,
      ),
      // textSelectionTheme: TextSelectionThemeData(
      //     selectionColor: isDarkTheme ? Colors.white : Colors.black),
      colorScheme: ColorScheme.fromSwatch(
        // backgroundColor: isDarkTheme ? Colors.blue : Colors.white,
        primarySwatch: isDarkTheme
            ? WSColors.whiteMaterialColor
            : WSColors.lightGreenMaterialColor,
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      ),
      // .copyWith(
      //     background: isDarkTheme ? Colors.grey[900] : const Color(0xffF1F5FB)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor:
              isDarkTheme ? Colors.white : WSColors.lightGreenMaterialColor,
          backgroundColor: isDarkTheme ? Colors.grey[800] : Colors.white),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: isDarkTheme ? Colors.white : WSColors.lightGreenMaterialColor,
      ),

      //Theme for toggle switch button
      switchTheme: SwitchThemeData(
          thumbColor: isDarkTheme
              ? MaterialStateProperty.all(Colors.grey)
              : MaterialStateProperty.all(WSColors.lightGreenColor),
          trackColor: isDarkTheme
              ? MaterialStateProperty.all(Colors.white)
              : MaterialStateProperty.all(Colors.grey)),
      iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
        iconColor: isDarkTheme
            ? MaterialStateProperty.all(Colors.white)
            : MaterialStateProperty.all(Colors.grey[800]),
      )),
      // toggleButtonsTheme: ToggleButtonsThemeData(
      //     color: isDarkTheme ? Colors.white : WSColors.lightGreenColor)
    );
  }
}
