import 'package:flutter/material.dart';

import '../../resources/ws_colors.dart';

class WSAppTheme {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primaryColor: isDarkTheme ? Colors.yellow : Colors.white,
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
      canvasColor: isDarkTheme ? Colors.grey[900] : Colors.grey[50],
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
      //  Theme.of(context).buttonTheme.copyWith(
      //     colorScheme: isDarkTheme
      //         ? const ColorScheme.dark()
      //         : const ColorScheme.light()),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor:
            isDarkTheme ? Colors.grey[800] : WSColors.lightGreenMaterialColor,
      ),
      textSelectionTheme: TextSelectionThemeData(
          selectionColor: isDarkTheme ? Colors.white : Colors.black),
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

      // toggleButtonsTheme: ToggleButtonsThemeData(
      //     color: isDarkTheme ? Colors.white : WSColors.lightGreenColor)
    );
  }
}
