import 'package:flutter/material.dart';
import 'package:mania/resources/colours.dart';

ThemeData appTheme() {
  return ThemeData(
    primarySwatch: Colours.primarySwatch,
    primaryColor: Colours.primaryColor,
    colorScheme: ColorScheme.light(
      primary: Colours.primaryColor,
      onPrimary: Colors.white,
      secondary: Colours.accentColor,
      onSecondary: Colors.white,
    ),
    hintColor: Colours.hintColor,
    dividerColor: Colours.dividerColor,
    scaffoldBackgroundColor: Colours.scaffoldColor,
    canvasColor: Colours.canvasColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
