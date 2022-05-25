import 'package:flutter/material.dart';
import 'package:mania/resources/colours.dart';

ThemeData appLightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colours.primarySwatch,
    primaryColor: Colours.primaryColor,
    colorScheme: const ColorScheme.light(
      primary: Colours.primaryColor,
      secondary: Colours.secondaryColor,
      onSecondary: Colors.white,
    ),
    backgroundColor: Colours.light.appBackground,
    scaffoldBackgroundColor: Colours.light.appScaffoldColor,
    hintColor: Colours.hintColor,
    dividerColor: Colours.dividerColor,
    canvasColor: Colours.canvasColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    shadowColor: Colors.grey,
    textTheme: const TextTheme().copyWith(
      bodyText2: const TextStyle().copyWith(color: Colours.light.appTextColor),
      subtitle1: const TextStyle().copyWith(color: Colours.light.appTextColor),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: Colours.light.appTextColor,
      textColor: Colours.light.appTextColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showUnselectedLabels: false,
      showSelectedLabels: true,
      elevation: 0,
    ),
  );
}

ThemeData appDarkTheme() {
  return appLightTheme().copyWith(
    brightness: Brightness.dark,
    backgroundColor: Colours.dark.appBackground,
    scaffoldBackgroundColor: Colours.dark.appScaffoldColor,
    textTheme: appLightTheme().textTheme.copyWith(
          headline6: appLightTheme().textTheme.headline6?.copyWith(
                color: Colours.dark.appTextColor,
              ),
          bodyText2: appLightTheme().textTheme.bodyText1?.copyWith(
                color: Colours.dark.appTextColor,
              ),
          subtitle1: appLightTheme().textTheme.subtitle1?.copyWith(
                color: Colours.dark.appTextColor,
              ),
        ),
    listTileTheme: appLightTheme().listTileTheme.copyWith(
          iconColor: Colours.dark.appTextColor,
          textColor: Colours.dark.appTextColor,
        ),
    shadowColor: Colors.black,
  );
}
