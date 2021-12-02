import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mania/models/ApiMessage.dart';
import 'package:mania/models/ApiUser.dart';
import 'package:mania/screens/followers_screen.dart';
import 'package:mania/screens/followings_screen.dart';
import 'package:mania/screens/home_screen.dart';
import 'package:mania/screens/login_screen.dart';
import 'package:mania/screens/message_screen.dart';
import 'package:mania/screens/message_write_screen.dart';
import 'package:mania/screens/profile/profile_edit_screen.dart';
import 'package:mania/screens/profile/profile_screen.dart';
import 'package:mania/screens/search_screen.dart';
import 'package:mania/screens/splash_screen.dart';

final RouteFactory routes = (settings) {
  Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    "/": (BuildContext context) => SplashScreen(),
    "/login": (BuildContext context) => LoginScreen(),
    "/home": (BuildContext context) => HomeScreen(),
    "/profile": (BuildContext context) => ProfileScreen(settings.arguments as ApiUser),
    "/profile/edit": (BuildContext context) => ProfileEditScreen(settings.arguments as ApiUser),
    "/search": (BuildContext context) => SearchScreen(),
    "/followings": (BuildContext context) => FollowingsScreen(settings.arguments as ApiUser),
    "/followers": (BuildContext context) => FollowersScreen(settings.arguments as ApiUser),
    "/message": (BuildContext context) => MessageScreen(settings.arguments as ApiMessage),
    "/message/write": (BuildContext context) => MessageWriteScreen(),
  };

  return MaterialPageRoute(
    builder: (BuildContext context) => routes[settings.name]!(context),
    settings: settings,
  );
};
