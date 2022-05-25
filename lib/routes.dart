import 'package:flutter/material.dart';
import 'package:mania/models/api_message.dart';
import 'package:mania/models/api_user.dart';
import 'package:mania/screens/followers_screen.dart';
import 'package:mania/screens/followings_screen.dart';
import 'package:mania/screens/gameviewers_screen.dart';
import 'package:mania/screens/giveaways_screen.dart';
import 'package:mania/screens/home_screen.dart';
import 'package:mania/screens/login_screen.dart';
import 'package:mania/screens/message_screen.dart';
import 'package:mania/screens/message_write_screen.dart';
import 'package:mania/screens/profile/profile_edit_screen.dart';
import 'package:mania/screens/profile/profile_screen.dart';
import 'package:mania/screens/projects_create_screen.dart';
import 'package:mania/screens/projects_screen.dart';
import 'package:mania/screens/settings_screen.dart';
import 'package:mania/screens/splash_screen.dart';

MaterialPageRoute routes(RouteSettings settings) {
  final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    "/": (BuildContext context) => const SplashScreen(),
    "/login": (BuildContext context) => const LoginScreen(),
    "/home": (BuildContext context) => const HomeScreen(),
    "/profile": (BuildContext context) => ProfileScreen(settings.arguments! as ApiUser),
    "/profile/edit": (BuildContext context) => ProfileEditScreen(settings.arguments! as ApiUser),
    "/followings": (BuildContext context) => FollowingsScreen(settings.arguments! as ApiUser),
    "/followers": (BuildContext context) => FollowersScreen(settings.arguments! as ApiUser),
    "/message": (BuildContext context) => MessageScreen(settings.arguments! as ApiMessage),
    "/message/write": (BuildContext context) => MessageWriteScreen(
          parentMessageId: settings.arguments != null ? settings.arguments! as int : null,
        ),
    "/giveaways": (BuildContext context) => const GiveAwaysScreen(),
    "/gameviewers": (BuildContext context) => const GameViewersScreen(),
    "/projects": (BuildContext context) => const ProjectsScreen(),
    "/projects/create": (BuildContext context) => const ProjectsCreateScreen(),
    "/settings": (BuildContext context) => const SettingsScreen(),
  };

  return MaterialPageRoute(
    builder: (BuildContext context) => routes[settings.name]!(context),
    settings: settings,
  );
}
