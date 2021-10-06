import 'package:flutter/material.dart';
import 'package:mania/app/System.dart';
import 'package:mania/resources/strings.dart';
import 'package:mania/routes.dart';
import 'package:mania/theme/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    System.transparentStatusBar();

    return MaterialApp(
      title: Strings.appName,
      theme: appTheme(),
      initialRoute: '/',
      routes: routes,
    );
  }
}
