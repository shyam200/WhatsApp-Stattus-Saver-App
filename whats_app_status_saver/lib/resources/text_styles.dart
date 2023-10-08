import 'package:flutter/material.dart';

//overriding flutter text theme
TextTheme appTextTheme(BuildContext context) => Theme.of(context).textTheme;

// TextTheme get wsTextTheme => const TextTheme(
//       displayMedium: TextStyle(
//           fontSize: 24,
//           fontFamily: 'PlayfairDisplay',
//           fontWeight: FontWeight.bold),
//       bodyLarge: TextStyle(
//           fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
//       bodyMedium: TextStyle(fontSize: 16, fontFamily: 'Montserrat'),
//     );

abstract class TextStyles {
  // static const headingText = TextStyle(
  //     color: Colors.black,
  //     fontSize: 24,
  //     fontFamily: 'PlayfairDisplay',
  //     fontWeight: FontWeight.bold);
  // static const bodyText = TextStyle();
  // static const bodyTextBold = TextStyle(
  //     fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Montserrat');
}
