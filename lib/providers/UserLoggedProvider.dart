import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/api/Requests.dart';
import 'package:mania/models/ApiUser.dart';
import 'package:mania/providers/UserFollowingsProvider.dart';

final userLoggedProvider = ChangeNotifierProvider<UserLoggedNotifier>((ref) => UserLoggedNotifier(ref));

class UserLoggedNotifier extends ChangeNotifier {
  Ref ref;
  ApiUser user = ApiUser.empty;

  UserLoggedNotifier(this.ref) {
    getUser();
  }

  Future getUser({bool updateFollowings = true}) async {
    return Requests.getUserInformations().then((value) {
      user = value.response ?? ApiUser.empty;
      notifyListeners();

      if (updateFollowings) {
        ref.read(userFollowingsProvider).getUsers();
      }
    }).catchError((error) {
      print("Error: $error");
    });
  }
}
