import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/api/RestClient.dart';
import 'package:mania/models/ApiMessage.dart';
import 'package:mania/models/ApiUser.dart';

final userProvider = ChangeNotifierProvider<UserNotifier>((ref) => UserNotifier(ref));

class UserNotifier extends ChangeNotifier {
  Ref ref;
  ApiUser user = ApiUser.empty;
  List<ApiMessage> messages = [];

  UserNotifier(this.ref) {
    getUser();
    getMessages();
  }

  Future getUser({int? userId}) async {
    if (userId != null) {
      return RestClient.service.getUserInformationWithUserId(userId).then((value) {
        user = value.response ?? ApiUser.empty;
        notifyListeners();
      });
    }
  }

  Future getMessages({int? userId}) async {
    if (userId != null) {
      return RestClient.service.getUserMessages(userId).then((value) {
        messages = value.response ?? [];
        notifyListeners();
      });
    }
  }
}
