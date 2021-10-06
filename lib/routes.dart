import 'package:flutter/widgets.dart';
import 'package:mania/screens/home/home.dart';
import 'package:mania/screens/login/login2.dart';
import 'package:mania/screens/splash/splash.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => SplashScreen(),
  "/login": (BuildContext context) => Login2Screen(),
  "/home": (BuildContext context) => HomeScreen(),
};
