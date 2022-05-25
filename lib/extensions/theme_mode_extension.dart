import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

extension ThemeModeExtension on ThemeMode {
  bool isDark() => this == ThemeMode.dark;

  bool isLight() => this == ThemeMode.light;

  bool isSystem() => this == ThemeMode.system;

  Brightness brightness() {
    if (this == ThemeMode.dark) {
      return Brightness.dark;
    } else if (this == ThemeMode.light) {
      return Brightness.light;
    } else {
      return SchedulerBinding.instance!.window.platformBrightness;
    }
  }
}
