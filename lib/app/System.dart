import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timeago/timeago.dart' as timeago;

class System {
  static ThemeMode themeMode = ThemeMode.system;
  static String? countryCode;
  static List<String> availableCountryCode = ['en', 'fr'];

  static isDarkMode() => System.themeMode == ThemeMode.dark;

  static isLightMode() => System.themeMode == ThemeMode.light;

  static void initialize(BuildContext context) {
    initializeLocales();
  }

  static void initializeLocales() {
    countryCode = WidgetsBinding.instance?.window.locale.countryCode?.toLowerCase();

    timeago.setLocaleMessages('fr', timeago.FrMessages());
    if (countryCode != null && availableCountryCode.contains(countryCode)) {
      timeago.setDefaultLocale(countryCode!);
    }
  }

  /// Status bar dark icons and transparent background
  static void transparentStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
    );
  }

  /// Status bar dark icons and transparent background
  static void portraitOnly({bool normal = true, bool upsideDown = false}) {
    List<DeviceOrientation> orientations = [];

    if (normal) orientations.add(DeviceOrientation.portraitUp);
    if (upsideDown) orientations.add(DeviceOrientation.portraitDown);

    SystemChrome.setPreferredOrientations(orientations);
  }

  /// Get package info
// static Future<PackageInfo> getPackageInfo() async {
//   return await PackageInfo.fromPlatform();
// }
}
