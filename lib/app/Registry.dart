import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:flutter_twitch/flutter_twitch.dart' as FlutterTwitch;
import 'package:mania/models/ApiUser.dart';

class Registry {
  static FirebaseAuth.User? firebaseUser;
  static FlutterTwitch.User? twitchUser;

  static bool isAuth() => (firebaseUser != null || twitchUser != null);

  static ApiUser? apiUser;

  static List<ApiUser> followingUsers = List.empty(growable: true);
}
