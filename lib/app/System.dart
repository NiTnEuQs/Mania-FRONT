import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class System {
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

  /// Get package info
// static Future<PackageInfo> getPackageInfo() async {
//   return await PackageInfo.fromPlatform();
// }
}
