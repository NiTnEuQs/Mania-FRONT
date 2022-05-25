import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/api/requests.dart';
import 'package:mania/models/api_user.dart';
import 'package:mania/providers/user_followings_provider.dart';

final userLoggedProvider = ChangeNotifierProvider<UserLoggedNotifier>((ref) => UserLoggedNotifier(ref));

class UserLoggedNotifier extends ChangeNotifier {
  UserLoggedNotifier(this.ref) {
    getUser();
  }

  Ref ref;
  ApiUser user = ApiUser.empty;

  Future getUser({bool updateFollowings = true}) async {
    return Requests.getUserInformations().then((value) {
      user = value.response ?? ApiUser.empty;
      notifyListeners();

      if (updateFollowings) {
        ref.read(userFollowingsProvider).getUsers();
      }
    });
  }
}
