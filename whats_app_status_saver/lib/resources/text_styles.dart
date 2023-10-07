import 'package:flutter/material.dart';

abstract class TextStyles {
  static const headingText = TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontFamily: 'PlayfairDisplay',
      fontWeight: FontWeight.bold);
  static const bodyText = TextStyle(fontSize: 16, fontFamily: 'Montserrat');
  static const bodyTextBold = TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Montserrat');
}
