import 'package:flutter/widgets.dart';
import 'package:mania/screens/home/home.dart';
import 'package:mania/screens/login/login.dart';
import 'package:mania/screens/splash/splash.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => SplashScreen(),
  "/login": (BuildContext context) => LoginScreen(),
  "/home": (BuildContext context) => HomeScreen(),
};
