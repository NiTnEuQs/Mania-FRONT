import 'package:flutter/material.dart';

extension BightnessExtension on Brightness {
  bool isDark() => this == Brightness.dark;

  bool isLight() => this == ThemeMode.light;
}
