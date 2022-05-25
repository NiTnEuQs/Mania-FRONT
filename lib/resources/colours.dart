import 'package:flutter/material.dart';

class Colours {
  static _Light light = _Light();
  static _Dark dark = _Dark();

  // Theme

  static const MaterialColor primarySwatch = Colors.orange;
  static const Color primaryColor = Colors.orange;
  static const Color secondaryColor = Colors.orange;
  static const Color accentColor = Colors.deepOrangeAccent;
  static const Color hintColor = Color(0xFF999999);
  static const Color dividerColor = Colors.white;
  static const Color buttonColor = Colors.white;
  static const Color canvasColor = primaryColor;

  // Misc

  static const Color greyInput = Color(0xFFE0E0E0);
  static const Color whiteInput = Color(0xFFFFFFFF);
  static const Color hint = Color(0xFFAAAAAA);
  static const Color link = secondaryColor;

  static const Color appbarIcon = Colors.white;
  static const Color appbarIconBackground = Colors.black38;
  static const Color appBackground = Color(0xFFFFFFFF);

  // static const Color appBackground = Color(0xFFF5F5F5);
  static const Color separator = Color(0xFFD94800);
  static const Color badge = Color(0xFFFFA200);
  static const Color blackOverlay = Color(0x33000000);
  static const Color whiteOverlay = Color(0x33FFFFFF);
}

class _Light {
  Color get appBackground => const Color(0xFFFFFFFF);

  Color get appScaffoldColor => const Color(0xFFF7F7F7);

  Color get appTextColor => const Color(0xFF333333);
}

class _Dark {
  Color get appBackground => const Color(0xFF292929);

  Color get appScaffoldColor => const Color(0xFF212121);

  Color get appTextColor => Colors.white;
}
