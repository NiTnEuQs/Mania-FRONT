import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Colors.deepOrange,
    accentColor: Colors.deepOrangeAccent,
    hintColor: Colors.white,
    dividerColor: Colors.white,
    buttonColor: Colors.white,
    scaffoldBackgroundColor: Colors.black,
    canvasColor: Colors.black,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
