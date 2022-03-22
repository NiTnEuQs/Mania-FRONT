import 'package:flutter/material.dart';
import 'package:mania/resources/colours.dart';

ThemeData appTheme() {
  return ThemeData(
    primarySwatch: Colours.primarySwatch,
    primaryColor: Colours.primaryColor,
    colorScheme: ColorScheme.light(
      primary: Colours.primaryColor,
      onPrimary: Colors.white,
      secondary: Colours.secondaryColor,
      onSecondary: Colors.white,
    ),
    backgroundColor: Colours.light.appBackground,
    hintColor: Colours.hintColor,
    dividerColor: Colours.dividerColor,
    scaffoldBackgroundColor: Colours.scaffoldColor,
    canvasColor: Colours.canvasColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    shadowColor: Colors.grey,
  );
}

ThemeData appDarkTheme() {
  return appTheme().copyWith(
    backgroundColor: Colours.dark.appBackground,
    textTheme: appTheme().textTheme.apply(
          bodyColor: Colors.white,
        ),
    shadowColor: Colors.black,
  );
}
