import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeBrightnessProvider = StateNotifierProvider<ThemeBrightnessNotifier, Brightness>((ref) => ThemeBrightnessNotifier(ref));

class ThemeBrightnessNotifier extends StateNotifier<Brightness> {
  ThemeBrightnessNotifier(this.ref) : super(SchedulerBinding.instance!.window.platformBrightness);

  Ref ref;

  // Getters

  bool isDark() => state == Brightness.dark;

  bool isLight() => state == Brightness.light;

  // Setters

  Brightness set(Brightness brightness) => state = brightness;

  Brightness setDark() => set(Brightness.dark);

  Brightness setLight() => set(Brightness.light);
}
