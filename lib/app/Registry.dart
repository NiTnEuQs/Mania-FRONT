import 'package:firebase_auth/firebase_auth.dart';
import 'package:mania/models/ApiUser.dart';

class Registry {
  static User? firebaseUser;

  static ApiUser? apiUser;

  static List<ApiUser> followingUsers = List.empty(growable: true);
}
