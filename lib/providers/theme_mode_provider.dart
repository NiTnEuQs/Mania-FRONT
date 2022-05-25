import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/app/prefs.dart';
import 'package:mania/extensions/theme_mode_extension.dart';
import 'package:mania/providers/theme_brightness_provider.dart';

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) => ThemeModeNotifier(ref));

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier(this.ref) : super(ThemeMode.system);

  Ref ref;

  // Getters

  bool isSystem() => state == ThemeMode.system;

  bool isDark() => state == ThemeMode.dark;

  bool isLight() => state == ThemeMode.light;

  // Setters

  void set(ThemeMode mode) {
    state = mode;
    ref.read(themeBrightnessProvider.notifier).set(mode.brightness());
    prefs.setInt(Prefs.themeMode, mode.index);
  }

  void setSystem() => set(ThemeMode.system);

  void setDark() => set(ThemeMode.dark);

  void setLight() => set(ThemeMode.light);
}
