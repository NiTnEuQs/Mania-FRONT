import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/api/Requests.dart';
import 'package:mania/api/RestClient.dart';
import 'package:mania/models/ApiMessage.dart';
import 'package:mania/models/ApiUser.dart';

final userFollowingsProvider = ChangeNotifierProvider<UserFollowingsNotifier>((ref) => UserFollowingsNotifier(ref));

class UserFollowingsNotifier extends ChangeNotifier {
  Ref ref;
  List<ApiUser> users = [];
  List<ApiMessage> messages = [];

  UserFollowingsNotifier(this.ref) {
    getUsers();
    getRecentMessages();
  }

  Future getUsers() async {
    return Requests.updateUserFollowings().then((value) {
      users = value.response ?? [];
      notifyListeners();
    });
  }

  Future getRecentMessages({int? userId}) async {
    if (userId != null) {
      return RestClient.service.getFollowingsRecentMessages(userId).then((value) {
        messages = value.response ?? [];
        notifyListeners();
      });
    }
  }
}
