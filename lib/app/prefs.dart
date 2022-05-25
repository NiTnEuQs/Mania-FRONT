import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/providers/theme_mode_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

class Prefs {
  static String twitchAccessToken = "TwitchAccessToken";
  static String twitchRefreshToken = "TwitchRefreshToken";
  static String twitchTokenType = "TwitchTokenType";
  static String twitchExpiresIn = "TwitchExpiresIn";

  static String themeMode = "ThemeMode";

  static Future<SharedPreferences> initialize() async {
    return prefs = await SharedPreferences.getInstance();
  }

  static void setup(WidgetRef ref) {
    final int themeMode = prefs.getInt(Prefs.themeMode) ?? ThemeMode.system.index;
    ref.read(themeModeProvider.notifier).set(ThemeMode.values[themeMode]);
  }
}
