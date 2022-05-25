import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_twitch/flutter_twitch.dart' as flutter_twitch;
import 'package:mania/models/api_user.dart';

class Registry {
  static firebase_auth.User? firebaseUser;
  static flutter_twitch.User? twitchUser;

  static bool isAuth() => firebaseUser != null || twitchUser != null;

  static ApiUser? apiUser;

  static List<ApiUser> followingUsers = List.empty(growable: true);
}
